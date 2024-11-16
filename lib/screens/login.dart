import 'package:flutter/material.dart';
import 'package:travel_plan/components/login_item.dart';
import 'package:travel_plan/layout/authen_background.dart';
import 'package:travel_plan/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: AppColors.primaryColor_1,
          child: Stack(
            children: [
              AuthenBackground(
                additionalWidget: LoginItem(),
              )
            ],
          ),
        ));
  }
}
