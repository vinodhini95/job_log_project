import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_auth_elevator_btn.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_text_field.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/dropdown_text_field.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/dynamic_widget/utils/styles.dart';
import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:provider/provider.dart';
import 'package:windows_toast/windows_toast.dart';

class HelperService {
  void showAdvanceFilter(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController startDateController,
    TextEditingController endDateController,
    void Function()? onStarDateTab,
    String? Function(String?)? startDatevalidator,
    void Function()? onEndDateTab,
    String? Function(String?)? endDatevalidator,
    void Function()? onTab,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Consumer<JobLogProvider>(
                        builder: (context, jobLogProvider, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCenterTextAlign("Price Range"),

                              getSlideRangeValue(
                                context,
                                jobLogProvider.priceRange,
                                (values) {
                                  jobLogProvider.setPriceRange(values);
                                },
                              ),

                              getCenterTextAlign("Location Select"),
                              SizedBox(height: 10),
                              DropdownTextField(
                                onchangeValue: (value) {
                                  jobLogProvider.setLocation(value!);
                                },
                                selectedValue:
                                    jobLogProvider.selectedLocationValue,
                                labelText: 'Select Location',
                                listData: jobLogProvider.locations,
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),

                      getCenterTextAlign("Date Filter"),
                      SizedBox(height: 10),
                      AppTextFormField(
                        isRequired: false,
                        controller: startDateController,
                        readOnly: true,
                        labelText: "Start Date",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        suffixIcon: Icons.calendar_today,
                        suffixIconOnTap: onStarDateTab,
                        validator: startDatevalidator,
                      ),
                      SizedBox(height: 10),
                      AppTextFormField(
                        isRequired: false,
                        controller: endDateController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        readOnly: true,
                        labelText: "End Date",
                        suffixIcon: Icons.calendar_today,
                        suffixIconOnTap: onEndDateTab,
                        validator: endDatevalidator,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: AppEllevatedAuthButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        btnName: "Cancel",
                        textColor: blackColor,
                        primaryColor: primaryColor,
                        iconIsrequired: false,
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: AppEllevatedAuthButton(
                        iconIsrequired: false,
                        onPressed: onTab,
                        btnName: "Show",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //get Title
  getCenterTextAlign(String textField) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(textField, style: loderTextStyle),
    );
  }

  //get slide range value
  getSlideRangeValue(
    BuildContext context,
    RangeValues priceRange,
    void Function(RangeValues)? onChangedValue,
  ) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.teal,
        // ignore: deprecated_member_use
        inactiveTrackColor: Colors.teal.withOpacity(0.3),
        thumbColor: Colors.teal,
        // ignore: deprecated_member_use
        overlayColor: Colors.teal.withOpacity(0.2),
      ),
      child: RangeSlider(
        values: priceRange,
        min: 1,
        max: 10,
        divisions: 100,
        labels: RangeLabels(
          "₹${priceRange.start.toInt()}",
          "₹${priceRange.end.toInt()}",
        ),
        onChanged: onChangedValue,
      ),
    );
  }

  //dianamic datePicker
  selectDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            hintColor: globalColor,
            colorScheme: ColorScheme.light(primary: globalColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
  }

  //get Text field
  getTextFieldWioutTransulator(
    BuildContext context,
    String textField,
    TextStyle textStyle,
  ) {
    return Text(textField, style: textStyle);
  }

  //flutter Tost Message
  showTostMessage(String? errorMessage, BuildContext context) {
    WindowsToast.show(errorMessage!, context, 30);
  }

  //get circular Image
  getImageCicularImage(String filePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child:kIsWeb
        ? Image.network(filePath, width: 100, height: 100, fit: BoxFit.cover): Image.file(
        File(filePath),
        fit: BoxFit.cover,
        width: 80,
        height: 80,
      ),
    );
  }

  //fav Icon Widget
  getFavIcon() {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
      padding: const EdgeInsets.all(4),
      child: Icon(Icons.favorite, color: globalColor, size: 16),
    );
  }

  //get width sized box
  getSizedboxwidth(double widthvalue) {
    return SizedBox(width: widthvalue);
  }

  //get height sized box
  getSizedboxheight(double heightvalue) {
    return SizedBox(height: heightvalue);
  }

  //get star icon
  getStarIcons() {
    return Icon(Icons.star, color: orangeColor, size: 16);
  }

  //getText field
  getTextField(String textField) {
    return Text(textField, style: TextStyle(fontSize: 12));
  }

  //get Text field with style
  getTextFieldStyle(String textField, TextStyle textStyle) {
    return Text(textField, style: textStyle);
  }

  //show Title with border style
  getTextFieldContainer(String textField, TextStyle textStyle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: getTextFieldStyle(textField, textStyle),
    );
  }
}
