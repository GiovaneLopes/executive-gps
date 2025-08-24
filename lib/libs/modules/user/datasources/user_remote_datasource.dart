import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:executive_gps/libs/utils/network_checker.dart';
import 'package:executive_gps/libs/exceptions/generic_errors.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';
import 'package:executive_gps/libs/modules/user/exceptions/user_exceptions.dart';

abstract class UserRemoteDatasource {
  Future<EmployeeModel?> signIn(String email, String password);
  Future<EmployeeModel?> getCurrentUser();
  Future<void> recoverPassword(String email);
  Future<void> logout();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<EmployeeModel?> signIn(String email, String password) async {
    return await _safeCall(() async {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        final user = await getCurrentUser();
        return user;
      } else {
        throw Exception();
      }
    });
  }

  @override
  Future<EmployeeModel?> getCurrentUser() async {
    if (_auth.currentUser == null) {
      return null;
    }
    final userDoc =
        await db.collection('employees').doc(_auth.currentUser!.uid).get();
    if (userDoc.exists) {
      return EmployeeModel.fromJson(jsonDecode(jsonEncode(userDoc.data())))
          .copyWith(id: userDoc.id);
    }
    return null;
  }

  @override
  Future<void> recoverPassword(String email) async {
    return await _safeCall(() async {
      await _auth.sendPasswordResetEmail(email: email);
    });
  }

  @override
  Future<void> logout() async {
    return await _safeCall(() async {
      await _auth.signOut();
    });
  }

  Future<T> _safeCall<T>(Future<T> Function() action) async {
    try {
      if (!await NetworkChecker.isConnected()) {
        throw AppGenericErrors.noConnectionError;
      }
      return await action();
    } on FirebaseAuthException catch (e) {
      throw UserExceptions.fromFirebaseAuthException(e);
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
