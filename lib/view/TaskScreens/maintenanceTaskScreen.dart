import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/model/dataController.dart';

class MaintenanceTaskScreen extends StatelessWidget {
  final controller = Get.find<DataController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: controller.getMaintenanceTasks, icon: Icon(Icons.refresh,size: 35,))
          ],
        ),
        body: controller.maintenancetasks.length==0?Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There's no Maintenance tasks right now !",
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
                            controller.maintenancetasks[index].problem,
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
                            "Note : ${controller.maintenancetasks[index].note}",
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
                          Text("Items",style: TextStyle(fontSize: 20)),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            height: 150,
                            child: ListView.builder(
                                itemBuilder: (context,i)=>
                                Text(
                                  controller.maintenancetasks[index].items[i],
                                  style: TextStyle(fontSize: 20),
                                ),
                              itemCount: controller.maintenancetasks[index].items.length,
                            ),
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
                            controller.maintenancetasks[index].description,
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
                            "${controller.maintenancetasks[index].todayDate}\nfrom  ${controller.maintenancetasks[index].startTime}  to  ${controller.maintenancetasks[index].endTime}",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )));
              },
              child: ListTile(
                title: Text(controller.maintenancetasks[index].problem,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                subtitle: Text(controller.maintenancetasks[index].description,overflow: TextOverflow.ellipsis,
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
          itemCount: controller.maintenancetasks.length,
        )
    );
  }
}


