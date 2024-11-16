import 'package:flutter/material.dart';
import 'package:travel_plan/components/signup_two_item.dart';
import 'package:travel_plan/layout/authen_background.dart';
import 'package:travel_plan/styles/colors.dart';

class SignupTwoScreen extends StatefulWidget {
  const SignupTwoScreen({super.key});

  @override
  State<SignupTwoScreen> createState() => _SignupTwoScreenState();
}

class _SignupTwoScreenState extends State<SignupTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primaryColor_1,
        body: Stack(
          children: [
            AuthenBackground(
              additionalWidget: SignupTwoItem(),
            )
          ],
        ));
  }
}
