import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/utils/const.dart';

class OnboardingBackground extends StatelessWidget {
  OnboardingBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildHeaders(context),
        _buildCircleOnRight(),
        _buildCircleOnLeft(),
        _buildLogo(),
        _buildIcon(),
      ],
    );
  }

  _buildHeaders(BuildContext context) {
    return ClipPath(
      clipper: OnbClipper(context),
      child: Container(color: AppColors.primaryColor_1),
    );
  }

  Widget _buildCircleOnLeft() {
    return Positioned(
      left: -0.168 * Constants.deviceWidth,
      top: -0.04 * Constants.deviceHeight,
      child: CustomPaint(
        size: Size(
          0.44 * Constants.deviceWidth,
          0.21 * Constants.deviceHeight,
        ),
        painter: CircleLeft(),
      ),
    );
  }

  Widget _buildCircleOnRight() {
    return Positioned(
      right: -0.22 * Constants.deviceWidth,
      top: 0.32 * Constants.deviceHeight,
      child: CustomPaint(
        size: Size(
          0.44 * Constants.deviceWidth,
          0.21 * Constants.deviceHeight,
        ),
        painter: CircleRight(),
      ),
    );
  }

  _buildLogo() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0.17 * Constants.deviceHeight,
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 0.68 * Constants.deviceWidth,
        height: 0.19 * Constants.deviceHeight,
      ),
    );
  }

  _buildIcon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/earth.png'),
            ],
          ),
        ],
      ),
    );
  }
}

class OnbClipper extends CustomClipper<Path> {
  final BuildContext context;

  OnbClipper(this.context);

  @override
  Path getClip(Size size) {
    double desiredWidth = Constants.deviceWidth;
    double desiredHeight = Constants.deviceHeight * 0.6;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(desiredWidth, 0);
    path.lineTo(desiredWidth, desiredHeight);
    path.cubicTo(
      desiredWidth * 0.8303256,
      desiredHeight * 0.9124108,
      desiredWidth * 0.6986667,
      desiredHeight,
      desiredWidth * 0.4800000,
      desiredHeight,
    );
    path.cubicTo(
      desiredWidth * 0.3470641,
      desiredHeight * 0.9929379,
      desiredWidth * 0.3087718,
      desiredHeight * 0.9607715,
      desiredWidth * 0.2253333,
      desiredHeight * 0.8677355,
    );
    path.cubicTo(
      desiredWidth * 0.1157890,
      desiredHeight * 0.8521984,
      desiredWidth * 0.06153154,
      desiredHeight * 0.8321263,
      0,
      desiredHeight * 0.7404810,
    );
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CircleLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.primaryColor_2;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width,
        height: size.height,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CircleRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.accentColor_2;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width,
        height: size.height,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
