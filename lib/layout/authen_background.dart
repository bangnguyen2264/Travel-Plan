import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/utils/const.dart';

class AuthenBackground extends StatefulWidget {
  final Widget additionalWidget;

  AuthenBackground({
    required this.additionalWidget,
  });

  @override
  State<AuthenBackground> createState() => _AuthenBackgroundState();
}

class _AuthenBackgroundState extends State<AuthenBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0.024 * Constants.deviceHeight,
          left: 0,
          right: 0,
          child: _buildIcon(),
        ),
        Positioned(
          top: 0.1 * Constants.deviceHeight,
          left: 0.05 * Constants.deviceWidth,
          child: SvgPicture.asset('assets/icons/alien.svg'),
        ),
        Positioned(
          top: 0.05 * Constants.deviceHeight,
          right: 0.176 * Constants.deviceWidth,
          child: SvgPicture.asset('assets/icons/mouse.svg'),
        ),
        Positioned(
          top: 0.18 * Constants.deviceHeight,
          right: 0.05 * Constants.deviceWidth,
          child: SvgPicture.asset('assets/icons/calendar.svg'),
        ),
        _buildBottom(widget.additionalWidget),
      ],
    );
  }

  Widget _buildBottom(Widget additionalWidget) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 0.75 * Constants.deviceHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  additionalWidget,
                ],
              ), // Add any widget here
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 0.7 * Constants.deviceWidth,
      height: 0.4 * Constants.deviceHeight,
      child: Image.asset(
        'assets/images/earth.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
