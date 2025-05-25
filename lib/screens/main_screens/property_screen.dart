import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_auth_elevator_btn.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:gnb_project/dynamic_widget/utils/helper_service.dart';
import 'package:gnb_project/model/property_model.dart';
import 'package:gnb_project/service/service_file/analyse_service.dart';

class PropertyDetailPage extends StatefulWidget {
  final Property property;

  const PropertyDetailPage({required this.property, Key? key})
    : super(key: key);

  @override
  _PropertyDetailPageState createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late DateTime _entryTime;

  @override
  void initState() {
    super.initState();
    _entryTime = DateTime.now();
    AnalyticsManager().logView(widget.property.id);
  }

  @override
  void dispose() {
    final timeSpent = DateTime.now().difference(_entryTime);
    AnalyticsManager().logTimeSpent(widget.property.id, timeSpent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: widget.property.title,
        backButton: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              AnalyticsManager().logClick('image-${widget.property.id}');
            },
            child:
                /// Preview Image
                Center(
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: kIsWeb
                        ? Image.network(
                            widget.property.imagePath.path,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(widget.property.imagePath.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
          ),
          SizedBox(height: 10),
          AppEllevatedAuthButton(
            onPressed: () {
              AnalyticsManager().logClick('contact-${widget.property.id}');
              HelperService().showTostMessage(
                "There is no Seller Contact",
                context,
              );
            },
            btnName: 'Contact Seller',
            iconIsrequired: false,
          ),
        ],
      ),
    );
  }
}
