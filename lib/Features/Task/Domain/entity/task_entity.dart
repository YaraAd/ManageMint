class TaskEntity {
  final String taskId;
  final String devId;
  final bool isAssigned;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String creationDate;
  final String assignedTo ;
  final String status ;
  TaskEntity({
    this.taskId = '',
    required this.title,
    this.assignedTo = '',
    this.status = 'Open',
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.creationDate,
     this.devId = '',
    this.isAssigned = false
  });

  TaskEntity copyWith({
    String? taskId,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    String? creationDate,
    String? assignedTo,
    String? status,
    bool? isAssigned,
    String? devId
  }) {
    return TaskEntity(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      creationDate: creationDate ?? this.creationDate,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
      isAssigned: isAssigned ?? this.isAssigned,
        devId:  devId ?? this.devId
    );
  }
}
