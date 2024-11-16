import 'package:flutter/material.dart';
import 'package:travel_plan/components/arrow_back.dart';
import 'package:travel_plan/utils/const.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;
  final Widget? action;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.action,
    this.isBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        leadingWidth: 0.18 * Constants.deviceWidth,
        leading: isBack ? ArrowBack() : null,
        actions: [action ?? Container()],
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            // Replace with your desired font family
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            color: Color(0xff000000),
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
