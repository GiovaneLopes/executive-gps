import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/customers/models/customer_model.dart';

abstract class CustomerDatasource {
  Future<List<CustomerModel>> getCustomers();
  Future<void> addCustomer(
    CustomerModel customer,
    List<ImageModel>? images,
  );
  Future<void> updateCustomer(
    CustomerModel customer,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  );
  Future<void> deleteCustomer(String customerId);
}

class CustomerDatasourceImpl implements CustomerDatasource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<List<CustomerModel>> getCustomers() async {
    final querySnapshot = await db.collection('customers').get();
    return querySnapshot.docs
        .map((doc) => CustomerModel.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  @override
  Future<void> addCustomer(
    CustomerModel customer,
    List<ImageModel>? images,
  ) async {
    try {
      final customersRef = db.collection('customers');
      final novoUsuarioRef = customersRef.doc();
      var newUrls = <ImageModel>[];
      if (images?.isNotEmpty ?? false) {
        newUrls = await saveImages(novoUsuarioRef.id, images);
      }
      await customersRef
          .doc(novoUsuarioRef.id)
          .set(customer.copyWith(images: newUrls).toJson());
    } catch (e) {
      throw Exception('### Error adding Customer: $e');
    }
  }

  @override
  Future<void> updateCustomer(
    CustomerModel customer,
    List<ImageModel>? images,
    List<ImageModel>? deletedImages,
  ) async {
    try {
      final List<ImageModel> newUrls = await saveImages(
        customer.id!,
        images?.where((img) => img.file != null).toList(),
      );
      await deleteImages(customer.id!, deletedImages);
      final imagesUpdated = customer.images.isNotEmpty
          ? [
              ...customer.images,
              ...newUrls,
            ]
          : newUrls;
      await db
          .collection('customers')
          .doc(customer.id)
          .update(customer.copyWith(images: imagesUpdated).toJson());
    } catch (e) {
      throw Exception('### Error updating Customer: $e');
    }
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    try {
      await db.collection('customers').doc(customerId).delete();
    } catch (e) {
      throw Exception('Error deleting Customer: $e');
    }
  }

  Future<List<ImageModel>> saveImages(
      String userId, List<ImageModel>? images) async {
    try {
      final imageModels = <ImageModel>[];
      for (ImageModel image in images ?? []) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        final ref = storage.ref().child('customers/$userId/$fileName');
        await ref.putData(await File(image.file?.path ?? '').readAsBytes());
        final url = await ref.getDownloadURL();
        imageModels.add(ImageModel(url: url, name: fileName));
      }
      return imageModels;
    } catch (e) {
      throw Exception('Error saving image: $e');
    }
  }

  Future<void> deleteImages(String userId, List<ImageModel>? images) async {
    try {
      for (ImageModel image in images ?? []) {
        final ref = storage.ref().child('customers/$userId/${image.name}');
        await ref.delete();
      }
    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }
}
