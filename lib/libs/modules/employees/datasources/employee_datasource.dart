import 'dart:io';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:executive_gps/libs/utils/network_checker.dart';
import 'package:executive_gps/libs/exceptions/generic_errors.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';

abstract class EmployeeDatasource {
  Future<List<EmployeeModel>> getEmployees();
  Future<void> addEmployee(
      EmployeeModel employee, String password, List<ImageModel>? images);
  Future<void> updateEmployee(
    EmployeeModel employee,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  );
  Future<void> deleteEmployee(String employeeId);
}

class EmployeeDatasourceImpl implements EmployeeDatasource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    return await _safeCall(() async {
      final querySnapshot = await db.collection('employees').get();
      return querySnapshot.docs
          .map((doc) => EmployeeModel.fromJson(doc.data()).copyWith(id: doc.id))
          .toList();
    });
  }

  @override
  Future<void> addEmployee(
    EmployeeModel employee,
    String password,
    List<ImageModel>? images,
  ) async {
    await _safeCall(() async {
      HttpsCallable callable = functions.httpsCallable('createUserByAdmin');
      final response = await callable.call(<String, dynamic>{
        'email': employee.email,
        'password': password,
      });
      var newUrls = <ImageModel>[];
      if (images?.isNotEmpty ?? false) {
        newUrls = await saveImages(response.data['uid'], images);
      }
      await db
          .collection('employees')
          .doc(response.data['uid'])
          .set(employee.copyWith(images: newUrls).toJson());
    });
  }

  @override
  Future<void> updateEmployee(
    EmployeeModel employee,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  ) async {
    await _safeCall(() async {
      final List<ImageModel> newUrls = await saveImages(
        employee.id!,
        images?.where((img) => img.file != null).toList(),
      );
      await deleteImages(employee.id!, deletedImages);
      final imagesUpdated = employee.images.isNotEmpty
          ? [
              ...employee.images,
              ...newUrls,
            ]
          : newUrls;
      await db
          .collection('employees')
          .doc(employee.id)
          .update(employee.copyWith(images: imagesUpdated).toJson());
    });
  }

  @override
  Future<void> deleteEmployee(String employeeId) async {
    await _safeCall(() async {
      _deleteAuthUser(employeeId);
      await db.collection('employees').doc(employeeId).delete();
    });
  }

  Future<List<ImageModel>> saveImages(
      String userId, List<ImageModel>? images) async {
    return await _safeCall(() async {
      final imageModels = <ImageModel>[];
      for (ImageModel image in images ?? []) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        final ref = storage.ref().child('employees/$userId/$fileName');
        await ref.putData(await File(image.file?.path ?? '').readAsBytes());
        final url = await ref.getDownloadURL();
        imageModels.add(ImageModel(url: url, name: fileName));
      }
      return imageModels;
    });
  }

  Future<void> deleteImages(String userId, List<ImageModel>? images) async {
    _safeCall(() async {
      for (ImageModel image in images ?? []) {
        final ref = storage.ref().child('employees/$userId/${image.name}');
        await ref.delete();
      }
    });
  }

  Future<void> _deleteAuthUser(String uid) async {
    _safeCall(() async {
      HttpsCallable callable = functions.httpsCallable('deleteUser');
      await callable.call(<String, dynamic>{
        'uid': uid,
      });
    });
  }

  Future<T> _safeCall<T>(Future<T> Function() action) async {
    try {
      if (!await NetworkChecker.isConnected()) {
        throw AppGenericErrors.noConnectionError;
      }
      return await action();
    } on FirebaseFunctionsException catch (e) {
      debugPrint('Erro na Cloud Function:');
      debugPrint('Código: ${e.code}');
      debugPrint('Detalhes: ${e.details}');
      debugPrint('Mensagem: ${e.message}');
      rethrow;
    } catch (e) {
      log(e.toString());
      if (e is AppGenericErrors) {
        if (e.code == AppGenericErrors.noConnectionError.code) {
          throw AppGenericErrors.noConnectionError;
        }
      }
      throw AppGenericErrors.genericError;
    }
  }
}
