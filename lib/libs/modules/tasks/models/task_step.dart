import 'package:flutter/material.dart';

enum TaskStep {
  waiting,
  scheduled,
  completed,
  canceled;

  @override
  String toString() {
    switch (this) {
      case TaskStep.waiting:
        return 'Aguardando';
      case TaskStep.scheduled:
        return 'Agendado';
      case TaskStep.completed:
        return 'Concluído';
      case TaskStep.canceled:
        return 'Cancelado';
    }
  }

  static Color getColor(TaskStep? status) {
    switch (status) {
      case TaskStep.waiting:
        return Colors.orange;
      case TaskStep.scheduled:
        return Colors.blue;
      case TaskStep.completed:
        return Colors.green;
      case TaskStep.canceled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static List<TaskStep> get creationTask => [
        TaskStep.waiting,
        TaskStep.scheduled,
        TaskStep.canceled,
      ];
}
