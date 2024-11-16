import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';

class FormAuthen extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String labelText;
  final bool isFirst;
  final bool isFinal;
  // final bool isError;

  const FormAuthen({
    required this.controller,
    this.isPassword = false,
    required this.labelText,
    required this.isFirst,
    required this.isFinal,
    // this.isError = false,
  });

  @override
  State<FormAuthen> createState() => _FormAuthenState();
}

class _FormAuthenState extends State<FormAuthen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8 * Constants.deviceWidth,
      height: 0.1 * Constants.deviceHeight,
      decoration: BoxDecoration(
        color: Color(0xFFE6E8EC),
        borderRadius: BorderRadius.vertical(
          top: widget.isFirst ? Radius.circular(20) : Radius.zero,
          bottom: widget.isFinal ? Radius.circular(20) : Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Align(
          alignment: Alignment.center,
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
              suffixIcon: SvgPicture.asset(
                widget.isPassword
                    ? 'assets/icons/lock.svg'
                    : 'assets/icons/mail.svg',
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
