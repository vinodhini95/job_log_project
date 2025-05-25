import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';

class DropdownTextField extends StatelessWidget {
  final String labelText;
  final String? selectedValue;
  final List<String> listData;
  final Function(String?)? onchangeValue;
  const DropdownTextField({
    super.key,
    this.selectedValue,
    required this.listData,
    this.onchangeValue,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: globalColor),
        filled: true, // or your theme background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          borderSide: BorderSide(color: globalColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: globalColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: globalColor, width: 2),
        ),
      ),
      dropdownColor: primaryColor,
      iconEnabledColor: globalColor,
      value: selectedValue,
      items: listData.map((location) {
        return DropdownMenuItem(value: location, child: Text(location));
      }).toList(),
      onChanged: onchangeValue,
    );
  }
}
