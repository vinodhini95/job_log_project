import 'package:flutter/material.dart';
import 'package:gnb_project/screens/main_screens/image_upload.dart';
import 'package:gnb_project/screens/main_screens/job_log_screen.dart';
import 'package:gnb_project/screens/main_screens/property_list.dart';

import '../../screens/main_screens/home_screen.dart';

class Routers {
  static const String home = "/home";
  static const String jobList = "/jobList";
  static const String imageUpload = "/imageUpload";
  static const String propertylist = "/property";

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => const HomeScreen(),
    jobList: (BuildContext context) => JobListData(),
    imageUpload: (BuildContext context) => ImageUploadScreen(),
    propertylist: (BuildContext context) => PropertyListPage()
  };
}
