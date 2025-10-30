import 'dart:io';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:executive_gps/libs/utils/network_checker.dart';
import 'package:executive_gps/libs/exceptions/generic_errors.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_model.dart';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_image_model.dart';
import 'package:executive_gps/libs/modules/tasks/models/task_answers_model.dart';

abstract class TaskDatasource {
  Future<List<TaskModel>> getTasks(String? employeeId);
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> saveTaskAnswers(String id, TaskAnswersModel answers);
  Future<void> deleteTask(String taskId);
  Future<void> clearTasks();
  Future<TaskAnswersModel?> getAnswers(String taskId);
}

class TaskDatasourceImpl implements TaskDatasource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final int pageSize = 10;
  bool hasMore = true;
  DocumentSnapshot? _lastDocument;
  final _documents = <DocumentSnapshot>[];

  @override
  Future<List<TaskModel>> getTasks(String? employeeId) async {
    return await _safeCall(() async {
      Query query = db
          .collection('tasks')
          .limit(pageSize)
          .orderBy('dueDate', descending: true);
      if ((_lastDocument != null || _documents.isEmpty) && hasMore) {
        if (employeeId != null) {
          query =
              db.collection('tasks').where('employeeId', isEqualTo: employeeId);
        }
        if (_lastDocument != null) {
          query = query.startAfterDocument(_lastDocument!);
        }
        final querySnapshot = await query.get();
        if (querySnapshot.docs.isNotEmpty) {
          hasMore = querySnapshot.docs.length == pageSize;
          _documents.addAll(querySnapshot.docs);
          _lastDocument = querySnapshot.docs.last;
        }

        return _documents
            .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>)
                .copyWith(id: doc.id))
            .toList();
      }
      return [];
    });
  }

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    return await _safeCall(() async {
      final identifier = await db.collection('tasks').doc('identifier').get();
      final newIdentifier = (identifier.data()?['data'] ?? 0);
      await db
          .collection('tasks')
          .doc('identifier')
          .set({'data': (identifier.data()?['data'] ?? 0) + 1});
      final newTask = task.copyWith(
        identifier:
            '${(newIdentifier + 1).toString().padLeft(3, '0')}/${(DateTime.now().year % 100).toString().padLeft(2, '0')}',
      );
      final tasksRef = db.collection('tasks');
      final novoUsuarioRef = tasksRef.doc();
      await tasksRef.doc(novoUsuarioRef.id).set(newTask.toJson());
      return newTask;
    });
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    return await _safeCall(() async {
      await db.collection('tasks').doc(task.id).update(task.toJson());
      return task;
    });
  }

  @override
  Future<void> saveTaskAnswers(String id, TaskAnswersModel answers) async {
    await _safeCall(() async {
      final newImages = await saveImages(id, answers.images);
      await db
          .collection('task_answers')
          .doc(id)
          .set(answers.copyWith(images: newImages).toJson());
      await db.collection('tasks').doc(id).update({'step': 'completed'});
    });
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _safeCall(() async {
      await db.collection('tasks').doc(taskId).delete();
    });
  }

  Future<List<TaskImageModel>> saveImages(
      String userId, List<TaskImageModel>? images) async {
    return await _safeCall(() async {
      final imageModels = <TaskImageModel>[];
      for (TaskImageModel image in images ?? []) {
        final ref = storage.ref().child('tasks/$userId/${image.name}');
        await ref.putData(await File(image.file?.path ?? '').readAsBytes());
        final url = await ref.getDownloadURL();
        imageModels
            .add(TaskImageModel(url: url, name: image.name, type: image.type));
      }
      return imageModels;
    });
  }

  Future<void> deleteImages(String userId, List<ImageModel>? images) async {
    await _safeCall(() async {
      for (ImageModel image in images ?? []) {
        final ref = storage.ref().child('tasks/$userId/${image.name}');
        await ref.delete();
      }
    });
  }

  @override
  Future<void> clearTasks() async {
    hasMore = true;
    _lastDocument = null;
    _documents.clear();
  }

  @override
  Future<TaskAnswersModel?> getAnswers(String userId) async {
    return await _safeCall(() async {
      final doc = await db.collection('task_answers').doc(userId).get();
      if (doc.exists) {
        return TaskAnswersModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  Future<T> _safeCall<T>(Future<T> Function() action) async {
    try {
      if (!await NetworkChecker.isConnected()) {
        throw AppGenericErrors.noConnectionError;
      }
      return await action();
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
