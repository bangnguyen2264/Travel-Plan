import 'package:flutter/material.dart';
import 'package:travel_plan/components/signup_item.dart';
import 'package:travel_plan/layout/authen_background.dart';
import 'package:travel_plan/styles/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primaryColor_1,
        body: Stack(
          children: [
            AuthenBackground(
                additionalWidget: SignupItem(),
                )
          ],
        ));
  }
}
