import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/model/task.dart';

import 'maintenanceTask.dart';

class DataController extends GetxController{
  List<Task> newtasks = [];
  List<Task> suspendedtasks = [];
  List<Task> finishedtasks = [];
  List<MaintenanceTask> maintenancetasks = [];
  int page = 2;


  @override
  void onInit() {
    getAllTasks();
    super.onInit();
  }

  void changePage(int index){
    page = index;
    update();
  }
  void getNewTasks(){
    List<Task> tmp = [];
    FirebaseFirestore.instance
        .collection('newTasks')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        tmp.add(Task.fromJson(element.data()));
      });
      newtasks.clear();
      newtasks = tmp;
    }).catchError((error){});
    update();
  }
  void getSuspendedTasks(){
    List<Task> tmp = [];
    FirebaseFirestore.instance
        .collection('suspendedTasks')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        tmp.add(Task.fromJson(element.data()));
      });
      suspendedtasks.clear();
      suspendedtasks = tmp;
    }).catchError((error){});
    update();
  }
  void getFinishedTasks(){
    List<Task> tmp = [];
    FirebaseFirestore.instance
        .collection('finishedTasks')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        tmp.add(Task.fromJson(element.data()));
      });
      finishedtasks.clear();
      finishedtasks = tmp;
    }).catchError((error){});
    update();
  }
  void getMaintenanceTasks(){
    List<MaintenanceTask> tmp = [];
    FirebaseFirestore.instance
        .collection('maintenanceTasks')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        tmp.add(MaintenanceTask.fromJson(element.data()));
        maintenancetasks.clear();
        maintenancetasks = tmp;
      });
    }).catchError((error){});
    update();
  }
  void getAllTasks(){
    getNewTasks();
    getSuspendedTasks();
    getFinishedTasks();
    getMaintenanceTasks();
    update();
  }
}