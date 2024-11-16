import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/screens/login.dart';
import 'package:travel_plan/screens/signup_two.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/widgets/form_authen_widget.dart';

double deviceHeight = 0.0;
double deviceWidth = 0.0;

class SignupItem extends StatefulWidget {
  const SignupItem({Key? key}) : super(key: key);

  @override
  State<SignupItem> createState() => _SignupItemState();
}

class _SignupItemState extends State<SignupItem> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  //bool rememberUser = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    //final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        _buildLogo(context),
        SizedBox(height: 0.035 * deviceHeight),
        FormAuthen(
          controller: emailController,
          isFirst: true,
          isFinal: false,
          labelText: 'Your email',
        ),
        SizedBox(height: 0.004 * deviceHeight),
        FormAuthen(
          controller: nameController,
          isFinal: false,
          isFirst: false,
          labelText: 'Your name',
        ),
        SizedBox(height: 0.004 * deviceHeight),
        FormAuthen(
          controller: usernameController,
          isFinal: true,
          isFirst: false,
          labelText: 'Username',
        ),
        SizedBox(height: 0.035 * deviceHeight),
        _buildButton(),
        _buildTextNavigator(),
      ],
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () async {
        // String username = usernameController.text;
        // String password = passwordController.text;

        // bool loginSuccess = await ApiService().loginUser(username, password);

        // if (loginSuccess) {
        //   print('Login success');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignupTwoScreen(),
          ),
        );
        // } else {
        //print('Test continue');
        // }
      },
      child: Container(
        height: 0.06 * deviceHeight,
        width: 0.76 * deviceWidth,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor_1,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Continue",
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.0),
            SvgPicture.asset('assets/icons/continue.svg'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextNavigator() {
    return Container(
      margin: EdgeInsets.only(top: 0.02 * deviceHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Have account ?",
            style: AppStyles.Body1.copyWith(
              color: AppColors.primaryColor_1,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
              //print('Sign up button was pressed');
            },
            child: const Text(
              " Log in",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWeight = MediaQuery.of(context).size.width;
    return Container(
      width: 0.66 * deviceWeight,
      height: 0.15 * deviceHeight,
      margin: EdgeInsets.only(top: 0.08 * deviceHeight),
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
        color: AppColors.primaryColor_1,
      ),
    );
  }
}
