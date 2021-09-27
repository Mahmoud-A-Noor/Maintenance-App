import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_maintenance/model/maintenanceTask.dart';
import 'package:work_maintenance/model/preferences.dart';
import 'package:work_maintenance/model/user.dart';
import '../model/task.dart';

String getRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

void createUser({
  required String uid,
  required String username,
  required String email,
  required String password,
  required String role,
  required var context,
}) {
  User user = User(
      username: username,
      email: email,
      password: password,
      uid: uid,
      role: role);

  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(user.toMap())
      .then((value) {})
      .catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "an Error occurred while creating account",
        softWrap: true,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
    print(error);
  });
}

void createTask(
    {required String taskId,
    required String title,
    required String description,
    required String team,
    required String priority,
    required String startDate,
    required String expectedEndDate,
    required var context
    }) {
  Task task = Task(
      taskId: taskId,
      title: title,
      description: description,
      team: team,
      priority: priority,
      startDate: startDate,
      expectedEndDate: expectedEndDate,
      endDate: '',
      suspensionFeedback: '',
      feedback: '',
      status: 'started');

  FirebaseFirestore.instance
      .collection('newTasks')
      .doc(taskId)
      .set(task.toMap())
      .then((value) {})
      .catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "an Error occurred while creating task",
        softWrap: true,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
    print(error);
  });
}

void createMaintenanceTask(
    {required String taskId,
    required String problem,
    required String description,
    required String note,
    required List<String> items,
    required String startTime,
      required String endTime,
      required String todayDate,
    required var context
    }) {
  MaintenanceTask task = MaintenanceTask(
      taskId: taskId,
      problem: problem,
      description: description,
    note: note,
    items: items,
      startTime: startTime,
      endTime: endTime,
    todayDate: todayDate
  );

  FirebaseFirestore.instance
      .collection('maintenanceTasks')
      .doc(taskId)
      .set(task.toMap())
      .then((value) {})
      .catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "an Error occurred while creating task",
        softWrap: true,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
    print(error);
  });
}

Future<String> getRole(String uid) async{
  //String uid = await UserPreferences.getUID()!;
  String role = "";
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid).get().then((value) {
    User user = User.fromJson(value.data()!);
    role = user.role;
  }).catchError((error){});
  return role;
}

void suspendTask(Task task,String susfeedback){
  task.suspensionFeedback = susfeedback;
  task.status = "suspended";
  FirebaseFirestore.instance
      .collection('suspendedTasks')
      .doc(task.taskId)
      .set(task.toMap())
      .then((value) {})
      .catchError((error) {});

  FirebaseFirestore.instance
      .collection('newTasks')
      .doc(task.taskId)
      .delete().then((value) {}).catchError((error){});
}


void finishTask(Task task,String feedback){
task.feedback = feedback;
task.status = "finished";
FirebaseFirestore.instance
    .collection('finishedTasks')
    .doc(task.taskId)
    .set(task.toMap())
    .then((value) {})
    .catchError((error) {});

FirebaseFirestore.instance
    .collection('newTasks')
    .doc(task.taskId)
    .delete().then((value) {}).catchError((error){});
}

void finishSuspendedTask(Task task,String feedback){
  String todayDate = "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";
  task.feedback = feedback;
  task.status = "finished";
  task.endDate = todayDate;
  FirebaseFirestore.instance
      .collection('finishedTasks')
      .doc(task.taskId)
      .set(task.toMap())
      .then((value) {})
      .catchError((error) {});

  FirebaseFirestore.instance
      .collection('suspendedTasks')
      .doc(task.taskId)
      .delete().then((value) {}).catchError((error){});
}