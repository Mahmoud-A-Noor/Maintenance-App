import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_maintenance/model/dataController.dart';
import 'package:work_maintenance/model/preferences.dart';
import 'package:work_maintenance/view/taskScreen.dart';
import './view/loginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Maintenance',
      home: UserPreferences.getUID() != null? taskScreen():loginScreen() ,
    );
  }
}
