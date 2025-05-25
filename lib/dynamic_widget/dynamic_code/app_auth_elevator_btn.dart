
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/dynamic_widget/utils/helper_service.dart';
import 'package:gnb_project/dynamic_widget/utils/styles.dart';

class AppEllevatedAuthButton extends StatelessWidget {
  const AppEllevatedAuthButton({
    Key? key,
    required this.onPressed,
    required this.btnName,
    this.primaryColor,
    this.textColor,
    this.side,
    required this.iconIsrequired,
    this.icons,
    this.imagePath,
  }) : super(key: key);
  final void Function()? onPressed;
  final Color? primaryColor;
  final Color? textColor;
  final String btnName;
  final BorderSide? side;
  final bool iconIsrequired;
  final IconData? icons;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        // width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: buttonBorderRadius),
              elevation: 4,
              side: side,
              backgroundColor: primaryColor ?? globalColor,
              // backgroundColor: buttonColor,
              minimumSize: const Size(double.infinity, 45)),

          // ignore: sort_child_properties_last
          child: iconIsrequired == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imagePath != null
                        ? Image.asset(
                            imagePath!,
                            height: 23,
                            color: primaryColor,
                          )
                        : Icon(icons, size: 18),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: HelperService().getTextFieldWioutTransulator(
                            context, btnName, authBtnTextStyle)),
                  ],
                )
              : HelperService().getTextFieldWioutTransulator(
                  context,
                  btnName,
                  TextStyle(
                    color: textColor != null ? textColor! : primaryColor,
                    fontSize: 14,
                  )),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
