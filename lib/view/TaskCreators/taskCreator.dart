import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work_maintenance/components/functions.dart';
import 'package:work_maintenance/model/dataController.dart';
import 'package:work_maintenance/view/TaskScreens/newTaskScreen.dart';
import 'package:work_maintenance/view/taskScreen.dart';

class taskCreator extends StatefulWidget {

  @override
  State<taskCreator> createState() => _taskCreatorState();
}

class _taskCreatorState extends State<taskCreator> {

  final controller = Get.find<DataController>();
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var teamController = TextEditingController();
  var startdateController = TextEditingController();
  var enddateController = TextEditingController();
  String priority = "Low";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Task Creator",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder()),
                      validator: (value){
                        if(value!.isEmpty)
                          return "Title mustn't be empty";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder()),
                      validator: (value){
                        if(value!.isEmpty)
                          return "Description mustn't be empty";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: teamController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Team',
                          prefixIcon: Icon(Icons.people),
                          border: OutlineInputBorder()),
                      validator: (value){
                        if(value!.isEmpty)
                          return "team mustn't be empty";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        buildPriorityItem("Low",Colors.blue),
                        SizedBox(width: 20,),
                        buildPriorityItem("Medium",Colors.amber),
                        SizedBox(width: 20,),
                        buildPriorityItem("High",Colors.red),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: startdateController,
                      keyboardType: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 3660)),
                        ).then((value) {
                          startdateController.text =
                              DateFormat.yMd().format(value!);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Start Date shouldn't be null";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: 'Start Date',
                        labelText: 'Task Start Date',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    TextFormField(
                      controller: enddateController,
                      keyboardType: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 3660)),
                        ).then((value) {
                          enddateController.text =
                              DateFormat.yMd().format(value!);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return "End Date shouldn't be null";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: 'End Date',
                        labelText: 'Task End Date',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () {

                            String taskId = getRandomString(70);

                            if(formkey.currentState!.validate())
                            {
                              createTask(
                                taskId: taskId,
                                title: titleController.text,
                                description: descriptionController.text,
                                team: teamController.text,
                                priority: priority,
                                startDate: startdateController.text,
                                expectedEndDate: enddateController.text,
                                context: context,
                              );
                              titleController.text = "";
                              descriptionController.text = "";
                              teamController.text = "";
                              priority = "Low";
                              startdateController.text = "";
                              enddateController.text = "";

                              controller.getNewTasks();
                            }
                          },
                          child: Text("Create Task", style: TextStyle(fontSize: 20))),
                      width: double.infinity,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  Expanded buildPriorityItem(String pri,Color color) {
    return Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            priority = pri;
                          });
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Icon(Icons.local_fire_department_sharp),
                                SizedBox(height: 10,),
                                Text(pri,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          height: 74,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: priority==pri ? 0.0 : 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
  }
}
