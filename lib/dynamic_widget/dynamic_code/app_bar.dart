// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final AppBar appBar;
  final bool? backButton;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final GlobalKey<ScaffoldState>? scafkey;
  final void Function()? onTap;
  final void Function()? onTap1;
  
  const BaseAppBar(
      {Key? key,
      this.backButton,
      this.title,
      this.scafkey,
      required this.appBar,
      this.actions,
      this.bottom,
      this.onTap,
      this.onTap1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        // shadowColor: Theme.of(context).primaryColor,
        titleSpacing: 3,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: backButton == true
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:  Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                //replace with our own icon data.
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  'assets/images/gnb_c_logo.png',
                  height: 50,
                  width: 50,
                ),
              ),
        title: title == null
            ? Text('GNB Project',
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontFamily: fontFamily))
            : Text(title!,
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontFamily: fontFamily)),
                    actions: [
      if (onTap != null)
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.filter_list,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ),
      if (onTap1 != null)
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: onTap1,
            child: Icon(
              Icons.refresh,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        )
    ],);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
