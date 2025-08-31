enum TaskType {
  installation,
  removal,
  maintenance,
  vehicleChange,
  ownerChange;

  @override
  String toString() {
    switch (this) {
      case TaskType.installation:
        return 'Instalação';
      case TaskType.removal:
        return 'Remoção';
      case TaskType.maintenance:
        return 'Manutenção';
      case TaskType.vehicleChange:
        return 'Troca de Veículo';
      case TaskType.ownerChange:
        return 'Troca de Proprietário';
      default:
        return '';
    }
  }

  static List<TaskType> get allValues => [
        TaskType.installation,
        TaskType.removal,
        TaskType.maintenance,
        TaskType.vehicleChange,
        TaskType.ownerChange,
      ];
}
