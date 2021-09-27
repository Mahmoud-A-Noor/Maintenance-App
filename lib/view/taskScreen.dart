import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/model/dataController.dart';
import 'package:work_maintenance/model/preferences.dart';
import 'package:work_maintenance/view/TaskCreators/taskCreator.dart';
import 'package:work_maintenance/view/TaskScreens/maintenanceTaskScreen.dart';
import 'package:work_maintenance/view/TaskScreens/newTaskScreen.dart';
import 'package:work_maintenance/view/TaskScreens/suspendedTaskScreen.dart';

import 'TaskCreators/maintenanceCreator.dart';
import 'TaskScreens/finishedTaskScreen.dart';

class taskScreen extends StatelessWidget {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final color = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
        builder: (controller) {
      return Scaffold(
        body: controller.page == 2 ? UserPreferences.getUserRole() == 'user' ? MaintenanceCreator() : taskCreator()
            : controller.page == 0? SuspendedTaskScreen():controller.page == 1?NewTaskScreen()
            :controller.page == 3?FinishedTaskScreen():MaintenanceTaskScreen(),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.more_time, size: 30, color: color,),
            Icon(Icons.description_outlined, size: 30, color: color,),
            Icon(Icons.add, size: 30, color: color,),
            Icon(Icons.task, size: 30, color: color,),
            Icon(Icons.settings, size: 30, color: color,)
          ],
          color: Colors.blue,
          buttonBackgroundColor: controller.page == 2
              ? Colors.blue
              : Colors.amber,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: controller.changePage,
          letIndexChange: (index) => true,
        ),
      );
    });
  }
}
