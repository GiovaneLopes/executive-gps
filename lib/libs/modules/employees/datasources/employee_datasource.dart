import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:executive_gps/libs/modules/employees/models/employee_model.dart';

abstract class EmployeeDatasource {
  Future<List<EmployeeModel>> getEmployees();
  Future<void> addEmployee(EmployeeModel employee);
  Future<void> deleteEmployee(String employeeId);
}

class EmployeeDatasourceImpl implements EmployeeDatasource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final querySnapshot = await db.collection('employees').get();
    return querySnapshot.docs
        .map((doc) => EmployeeModel.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  @override
  Future<void> addEmployee(EmployeeModel employee) async {
    try {
      final cpfDigits = employee.cpf.replaceAll(RegExp(r'\D'), '');
      final first4Digits = int.parse(cpfDigits.substring(0, 4));
      if (employee.id == null) {
        HttpsCallable callable = functions.httpsCallable('createUserByAdmin');
        final response = await callable.call(<String, dynamic>{
          'email': employee.email,
          'password': 'gps@$first4Digits',
        });
        await db
            .collection('employees')
            .doc(response.data['uid'])
            .set(employee.toJson());
      } else {
        await db
            .collection('employees')
            .doc(employee.id)
            .update(employee.toJson());
      }
    } catch (e) {
      throw Exception('Error adding employee: $e');
    }
  }

  @override
  Future<void> deleteEmployee(String employeeId) async {
    try {
      _deleteAuthUser(employeeId);
      await db.collection('employees').doc(employeeId).delete();
    } catch (e) {
      throw Exception('Error deleting employee: $e');
    }
  }

  Future<void> _deleteAuthUser(String uid) async {
    try {
      HttpsCallable callable = functions.httpsCallable('deleteUser');
      await callable.call(<String, dynamic>{
        'uid': uid,
      });
    } on FirebaseFunctionsException catch (e) {
      debugPrint('Erro na Cloud Function:');
      debugPrint('Código: ${e.code}');
      debugPrint('Detalhes: ${e.details}');
      debugPrint('Mensagem: ${e.message}');
    } catch (e) {
      debugPrint('Ocorreu um erro inesperado: $e');
    }
  }
}
