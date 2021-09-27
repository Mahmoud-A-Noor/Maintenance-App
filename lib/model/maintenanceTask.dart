class MaintenanceTask{
  late String taskId;
  late String problem;
  late String description;
  late String note;
  late List items;
  late String startTime;
  late String endTime;
  late String todayDate;

  MaintenanceTask({
    required this.taskId,
    required this.problem,
    required this.description,
    required this.note,
    required this.items,
    required this.startTime,
    required this.endTime,
    required this.todayDate,
  });

  MaintenanceTask.fromJson(Map<String,dynamic> json){
    taskId = json['taskId'];
    problem  = json['problem'];
    description = json['description'];
    note = json['note'];
    items = json['items'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    todayDate = json['todayDate'];
  }

  Map<String,dynamic> toMap(){
    return {
      'taskId':taskId,
      'problem':problem,
      'description':description,
      'note':note,
      'items':items,
      'startTime':startTime,
      'endTime':endTime,
      'todayDate':todayDate,
    };
  }

}