import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_elevator_button.dart';
import 'package:gnb_project/dynamic_widget/utils/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(backButton: false, appBar: AppBar()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppElevatorButton(
              label: 'Load Data Infinite Loop',
              onPressed: () {
                 Navigator.pushNamed(context, Routers.jobList);
              }),
          AppElevatorButton(
              label: 'Take Image',
              onPressed: () {
                Navigator.pushNamed(context, Routers.imageUpload);
              }),
          AppElevatorButton(
              label: 'Property List',
              onPressed: () {
                Navigator.pushNamed(context, Routers.propertylist);
              }),
        ],
      ),
    );
  }
}
