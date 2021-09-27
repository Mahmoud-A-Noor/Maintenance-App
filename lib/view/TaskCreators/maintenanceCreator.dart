import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work_maintenance/components/functions.dart';
import 'package:work_maintenance/model/dataController.dart';
import 'package:work_maintenance/view/taskScreen.dart';

class MaintenanceCreator extends StatefulWidget {

  @override
  State<MaintenanceCreator> createState() => _MaintenanceCreatorState();
}

class _MaintenanceCreatorState extends State<MaintenanceCreator> {

  final controller = Get.find<DataController>();
  var formkey = GlobalKey<FormState>();
  var problemController = TextEditingController();
  var descriptionController = TextEditingController();
  var noteController = TextEditingController();
  var itemController = TextEditingController();
  var starttimeController = TextEditingController();
  var endtimeController = TextEditingController();
  String priority = "Low";
  List<String> items = [];


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
                      "Maintenance Creator",
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: problemController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Problem',
                          prefixIcon: Icon(Icons.report_problem_outlined),
                          border: OutlineInputBorder()),
                      validator: (value){
                        if(value!.isEmpty)
                          return "Problem mustn't be empty";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Note',
                          prefixIcon: Icon(Icons.note_outlined),
                          border: OutlineInputBorder()),
                      validator: (value){
                        if(value!.isEmpty)
                          return "note mustn't be empty";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: itemController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Items',
                          prefixIcon: Icon(Icons.toc_outlined),
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){
                                setState(() {
                                  if(itemController.text != "")
                                    if(!items.contains(itemController.text))
                                  items.add(itemController.text);
                                  itemController.text = "";
                                });
                              }, icon: Icon(Icons.add)),
                              IconButton(onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Center(child: Text('Item List')),
                                        content: Container(
                                          width: 300,
                                          height: 500,
                                          child: ListView.builder(
                                            //shrinkWrap: true,
                                            itemCount: items.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return ListTile(
                                                title: Text(items[index]),
                                                trailing: IconButton(onPressed: (){
                                                  setState(() {
                                                    items.removeAt(index);
                                                    Get.back();
                                                  });
                                                }, icon: Icon(Icons.delete_forever_rounded,color: Colors.red,)),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    });
                              }, icon: Icon(Icons.preview_outlined)),
                            ],
                          ),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                TextFormField(
                  controller: starttimeController,
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now())
                        .then((value) {
                      starttimeController.text =
                          value!.format(context).toString();
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty)
                      return "start time shouldn't be null";
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.watch_later),
                    hintText: 'Task Start Time',
                    labelText: 'Task Start Time',
                  ),
                ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: endtimeController,
                      keyboardType: TextInputType.datetime,
                      onTap: () {
                        showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now())
                            .then((value) {
                          endtimeController.text =
                              value!.format(context).toString();
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return "end time shouldn't be null";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.watch_later),
                        hintText: 'Task End Time',
                        labelText: 'Task End Time',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () {
                            if(formkey.currentState!.validate())
                            {
                              String todayDate = "${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}";
                              String maintenanceTaskId = getRandomString(70);
                              createMaintenanceTask(
                                taskId: maintenanceTaskId,
                                problem: problemController.text,
                                description: descriptionController.text,
                                note: noteController.text,
                                items: items,
                                startTime: starttimeController.text,
                                endTime: endtimeController.text,
                                  todayDate: todayDate,
                                context: context
                              );
                              priority = "Low";
                              items = [];
                              problemController.text = "";
                              descriptionController.text = "";
                              starttimeController.text = "";
                              endtimeController.text = "";
                              noteController.text = "";
                              itemController.text = "";

                              controller.getMaintenanceTasks();
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
}
