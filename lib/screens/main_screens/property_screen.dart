import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:gnb_project/dynamic_widget/utils/helper_service.dart';
import 'package:gnb_project/dynamic_widget/utils/styles.dart';
import 'package:gnb_project/model/property_list_model.dart';
import 'package:gnb_project/service/service_file/analyse_service.dart';

class PropertyDetailPage extends StatefulWidget {
  final Propertylist property;

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
    AnalyticsManager().logView(widget.property.id!);
  }

  @override
  void dispose() {
    final timeSpent = DateTime.now().difference(_entryTime);
    AnalyticsManager().logTimeSpent(widget.property.id!, timeSpent);
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
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    AnalyticsManager().logClick('image-${widget.property.id}');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Image
                      if (widget.property.images != null &&
                          widget.property.images!.isNotEmpty)
                          HelperService().getImageCicularImage(widget.property.images![0], 200, double.infinity),
                       

                      // Small Preview Images
                      if (widget.property.images != null &&
                          widget.property.images!.isNotEmpty)
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.property.images!.length,
                              itemBuilder: (_, index) {
                                var imagePath = widget.property.images![index];
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: HelperService().getImageCicularImage(imagePath, 100, 100),
                                  ),
                                );
                              }),
                        ),

                      // Title + Rating + Location
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                //show star icon
                                HelperService().getStarIcons(),
                                //Use size box to give space
                                HelperService().getSizedboxwidth(4),
                                //show Text Field
                                HelperService().getTextField(
                                  "4.9 (300+ reviews)",
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    AnalyticsManager().logClick(
                                      'contact-${widget.property.id}',
                                    );
                                  },
                                  child: HelperService().getTextFieldContainer(
                                    "Apartment",
                                    titleTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            //Use size box to give space
                            HelperService().getSizedboxheight(4),
                            //show Text Field
                            HelperService().getTextFieldStyle(
                              'Woodland Apartment',
                              titleStyle,
                            ),
                            //Use size box to give space
                            HelperService().getSizedboxheight(2),
                            // Address
                            //show Text Field
                            HelperService().getTextFieldStyle(
                              '1012 Ocean avenue, New York, USA',
                              addressTextStyle,
                            ),
                          ],
                        ),
                      ),

                      // Tabs
                      const TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: "Description"),
                          Tab(text: "Gallery"),
                          Tab(text: "Review"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                // Tab 1: Description
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: HelperService().getTextFieldStyle(
                    "Spacious and stylish apartment in a prime location. Modern amenities with a great view.",
                    TextStyle(fontSize: 14),
                  ),
                ),

                // Tab 2: Gallery Grid

                GalleryGrid(images: widget.property.images!),

                // Tab 3: Review Placeholder
                Center(
                  child: HelperService().getTextFieldStyle(
                    "Review tab coming soon",
                    TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GalleryGrid extends StatelessWidget {
  List<String> images;
  GalleryGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, index) => ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: HelperService().getImageCicularImage(images[index], 60, 60),
        ),
      ),
    );
  }
}
