import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:gnb_project/screens/main_screens/property_screen.dart';
import 'package:gnb_project/service/service_file/analyse_service.dart';
import 'package:provider/provider.dart';

class PropertyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        backButton: true,
        title: "Properties",
      ),
      body: Consumer<JobLogProvider>(
        builder: (context, jobLogProvider, _) {
          return ListView.builder(
            itemCount: jobLogProvider.listProperty.length,
            itemBuilder: (context, index) {
              final property = jobLogProvider.listProperty[index];
              return ListTile(
                title: Text(property.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PropertyDetailPage(property: property),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: globalColor,
        child: Icon(Icons.analytics),
        onPressed: () {
          AnalyticsManager().printSummary(context);
        },
      ),
    );
  }
}
