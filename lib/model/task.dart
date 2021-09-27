class Task{
  late String taskId;
  late String title;
  late String description;
  late String team;
  late String priority;
  late String startDate;
  late String expectedEndDate;
  late String endDate;
  late String suspensionFeedback;
  late String feedback;
  late String status;

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.team,
    required this.priority,
    required this.startDate,
    required this.expectedEndDate,
    required this.endDate,
    required this.suspensionFeedback,
    required this.feedback,
    required this.status,
});

  Task.fromJson(Map<String,dynamic> json){
    taskId = json['taskId'];
    title  = json['title'];
    description = json['description'];
    team = json['team'];
    priority = json['priority'];
    startDate = json['startDate'];
    expectedEndDate = json['expectedEndDate'];
    endDate = json['endDate'];
    suspensionFeedback = json['suspensionFeedback'];
    feedback = json['feedback'];
    status = json['status'];
  }

  Map<String,dynamic> toMap(){
    return {
      'taskId':taskId,
      'title':title,
      'description':description,
      'team':team,
      'priority':priority,
      'startDate':startDate,
      'expectedEndDate':expectedEndDate,
      'endDate':endDate,
      'suspensionFeedback':suspensionFeedback,
      'feedback':feedback,
      'status':status
    };
  }

}