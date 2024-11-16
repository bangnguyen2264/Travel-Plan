import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 24, top: 8, bottom: 8),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(15), // Adjust the radius as needed
          border: Border.all(color: Color(0xffE5E7EB), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
          ),
        ),
      ),
    );
  }
}
