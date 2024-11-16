import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/components/arrow_back.dart';
import 'package:travel_plan/styles/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscuredOld = true;
  bool obscuredNew = true;
  bool obscuredConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leadingWidth: 64,
        leading: const ArrowBack(), // build navi button
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(24),
          //build input change password
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Password',
                style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor_1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Please enter a new password below that is different from the old password',
                maxLines: 2,
                style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff6B7280),
                ),
              ),
              const SizedBox(height: 56),
              FieldInput(
                hintText: 'Old Password',
                controller: oldPasswordController,
                obscuredText: obscuredOld,
                toggleVisibility: () {
                  setState(() {
                    obscuredOld = !obscuredOld;
                  });
                },
              ),
              FieldInput(
                hintText: 'New Password',
                controller: newPasswordController,
                obscuredText: obscuredNew,
                toggleVisibility: () {
                  setState(() {
                    obscuredNew = !obscuredNew;
                  });
                },
              ),
              FieldInput(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                obscuredText: obscuredConfirm,
                toggleVisibility: () {
                  setState(() {
                    obscuredConfirm = !obscuredConfirm;
                  });
                },
              ),
              const SizedBox(height: 230),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Change Password',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 100.5, vertical: 16),
                    backgroundColor: AppColors.primaryColor_1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscuredText;
  final VoidCallback toggleVisibility;

  const FieldInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscuredText,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 327,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.neutral_8.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          obscureText: obscuredText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: GestureDetector(
              onTap: toggleVisibility,
              child: Icon(
                obscuredText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
