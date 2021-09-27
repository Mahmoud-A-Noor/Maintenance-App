import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work_maintenance/components/functions.dart';
import 'package:work_maintenance/model/dataController.dart';

class SuspendedTaskScreen extends StatelessWidget {
  final controller = Get.find<DataController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: controller.getSuspendedTasks, icon: Icon(Icons.refresh,size: 35,))
          ],
        ),
        body: controller.suspendedtasks.length==0?Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "There's no suspended tasks !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ):ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                scaffoldKey.currentState!
                    .showBottomSheet((context) => Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            controller.suspendedtasks[index].title,
                            style: TextStyle(fontSize: 35),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Team : ${controller.suspendedtasks[index].team}",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Priority : ${controller.suspendedtasks[index].priority}",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "${controller.suspendedtasks[index].description}",
                            softWrap: true,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Delay Reason : ${controller.suspendedtasks[index].suspensionFeedback}",
                            softWrap: true,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "from  ${controller.suspendedtasks[index].startDate}  to  ${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Expected End Date : ${controller.suspendedtasks[index].expectedEndDate}",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: ()
                                  {
                                    var feedbackController = TextEditingController();
                                    Get.defaultDialog(title: "Feedback",
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextFormField(
                                                controller: feedbackController,
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                    labelText: 'Feedback',
                                                    prefixIcon: Icon(Icons.feedback_outlined),
                                                    border: OutlineInputBorder()),
                                              ),
                                              SizedBox(height: 20,),
                                              ElevatedButton(
                                                onPressed: (){
                                                  finishSuspendedTask(controller.suspendedtasks[index],feedbackController.text);
                                                  controller.getSuspendedTasks();
                                                  controller.getFinishedTasks();
                                                  Get.back();
                                                  Get.back();
                                                }, child: Text("Finish",style: TextStyle(fontSize: 25),),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    elevation: 7,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    )
                                                ),)
                                            ],
                                          ),
                                        )
                                    );
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Icon(Icons.task),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Finish",
                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    height: 74,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    )));
              },
              child: ListTile(
                title: Text(controller.suspendedtasks[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                subtitle: Text(controller.suspendedtasks[index].team,
                  style: TextStyle(fontSize: 17),),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            );
          },
          itemCount: controller.suspendedtasks.length,
        )
    );
  }
}

