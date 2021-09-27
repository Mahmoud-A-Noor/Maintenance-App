import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/model/dataController.dart';

class FinishedTaskScreen extends StatelessWidget {
  final controller = Get.find<DataController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: controller.getFinishedTasks, icon: Icon(Icons.refresh,size: 35,))
          ],
        ),
        body: controller.finishedtasks.length==0?Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There's no Finished tasks !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
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
                            controller.finishedtasks[index].title,
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
                            "Team : ${controller.finishedtasks[index].team}",
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
                            "Priority : ${controller.finishedtasks[index].priority}",
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
                            "${controller.finishedtasks[index].description}",
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
                            "Feedback : ${controller.finishedtasks[index].feedback}",
                            softWrap: true,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          controller.finishedtasks[index].suspensionFeedback != ''?Divider(
                            color: Colors.black,
                          ):Container(),
                          controller.finishedtasks[index].suspensionFeedback != ''?SizedBox(
                            height: 20,
                          ):Container(),
                          controller.finishedtasks[index].suspensionFeedback != ''?Text(
                            "Delay Reason : ${controller.finishedtasks[index].suspensionFeedback}",
                            softWrap: true,
                            style: TextStyle(fontSize: 20),
                          ):Container(),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          controller.finishedtasks[index].endDate == ''?Text(
                            "from  ${controller.finishedtasks[index].startDate}  to  ${controller.finishedtasks[index].expectedEndDate}",
                            style: TextStyle(fontSize: 20),
                          ):
                          Text(
                            "from  ${controller.finishedtasks[index].startDate}  to  ${controller.finishedtasks[index].endDate}",
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
                          )
                        ],
                      ),
                    )));
              },
              child: ListTile(
                title: Text(controller.finishedtasks[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                subtitle: Text(controller.finishedtasks[index].team,
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
          itemCount: controller.finishedtasks.length,
        )
    );
  }
}



