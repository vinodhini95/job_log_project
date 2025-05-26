import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/dynamic_widget/utils/helper_service.dart';
import 'package:gnb_project/dynamic_widget/utils/styles.dart';
import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:gnb_project/screens/main_screens/property_screen.dart';
import 'package:gnb_project/service/service_file/analyse_service.dart';
import 'package:provider/provider.dart';

class PropertyListPage extends StatelessWidget {
  const PropertyListPage({super.key});

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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PropertyDetailPage(property: property),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Image with heart icon
                        Stack(
                          children: [
                            //view image
                            HelperService().getImageCicularImage(
                              property.imagePath.path,
                            ),
                            //fav icon
                            Positioned(
                              top: 4,
                              right: 4,
                              child: HelperService().getFavIcon(),
                            ),
                          ],
                        ),

                        //Use size box to give space
                        HelperService().getSizedboxwidth(10),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Rating and tag
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      //show star icon
                                       HelperService().getStarIcons(),
                                      //Use size box to give space
                                      HelperService().getSizedboxwidth(4),
                                      //show Text Field
                                      HelperService().getTextField("4.9")
                                    ],
                                  ),

                                  HelperService().getTextFieldContainer(property.title,titleTextStyle)
                                 
                                ],
                              ),

                              //Use size box to give space
                              HelperService().getSizedboxheight(4),

                              // Title
                              //show Text Field
                                  HelperService().getTextFieldStyle('Woodland Apartment',titleStyle),

                              // Address
                              //show Text Field
                                  HelperService().getTextFieldStyle('1012 Ocean avenue, New York, USA',addressTextStyle),

                               //Use size box to give space
                              HelperService().getSizedboxheight(6),

                              // Stats row
                              Row(
                                children: [
                                  Icon(
                                    Icons.square_foot,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                    //Use size box to give space
                                  HelperService().getSizedboxwidth(4),
                                  //show Text Field
                                  HelperService().getTextField("1,225"),
                                   //Use size box to give space
                                  HelperService().getSizedboxwidth(12),

                                  Icon(Icons.bed, size: 14, color: Colors.grey),
                                   //Use size box to give space
                                  HelperService().getSizedboxwidth(4),
                                  //show Text Field
                                  HelperService().getTextField("3.2"),

                                  Spacer(),
                                  //show Text Field
                                  HelperService().getTextFieldStyle( '\$340/month',dollarSignstyle)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
