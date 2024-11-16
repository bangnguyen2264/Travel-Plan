import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/components/nav_bar.dart';
import 'package:travel_plan/screens/signup.dart';
import 'package:travel_plan/services/auth_service.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/widgets/form_authen_widget.dart';

class LoginItem extends StatefulWidget {
  const LoginItem({Key? key}) : super(key: key);

  @override
  State<LoginItem> createState() => _LoginItemState();
}

class _LoginItemState extends State<LoginItem> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool onProcess = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLogo(),
        SizedBox(height: 0.035 * Constants.deviceHeight),
        FormAuthen(
          controller: usernameController,
          labelText: 'Username',
          isFirst: true,
          isFinal: false,
        ),
        SizedBox(height: 0.004 * Constants.deviceHeight),
        FormAuthen(
          controller: passwordController,
          labelText: 'Password',
          isFirst: false,
          isFinal: true,
          isPassword: true,
        ),
        _buildRowSupport(),
        _buildAnotherLoginMethod(),
        _buildButton(),
        _buildTextSignUp(),
      ],
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ),
        );
        print('Test login');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.02 * Constants.deviceHeight),
        height: 0.06 * Constants.deviceHeight,
        width: 0.76 * Constants.deviceWidth,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor_1,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: Container(
            child: Text(
              "Sign in",
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowSupport() {
    return Container(
      margin: EdgeInsets.only(
        top: 0.005 * Constants.deviceHeight,
        bottom: 0.005 * Constants.deviceHeight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRememberPassword(),
          _buildForgotPassword(),
        ],
      ),
    );
  }

  Widget _buildRememberPassword() {
    return Row(
      children: [
        Checkbox(
            value: rememberUser,
            onChanged: (value) {
              setState(() {
                rememberUser = value!;
              });
            },
            activeColor: AppColors
                .primaryColor_1 // Change to your desired color when active
            ),
        Text(
          "Nhớ mật khẩu",
          style: AppStyles.smallText.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
        onTap: () {
          print('Forget password button was pressed');
        },
        child: Text(
          "Quên mật khẩu ?",
          style: AppStyles.smallText.copyWith(
            color: AppColors.primaryColor_1,
            fontWeight: FontWeight.w400,
          ),
        ));
  }

  Widget _buildAnotherLoginMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButtonLogin('assets/icons/gglogo.svg'),
        SizedBox(width: 0.02 * Constants.deviceWidth),
        _buildButtonLogin('assets/icons/fblogo.svg'),
      ],
    );
  }

  Widget _buildButtonLogin(String path) {
    return GestureDetector(
      onTap: () {
        onProcess ? null : handleLogin();
      },
      child: Container(
        width: 0.28 * Constants.deviceWidth,
        height: 0.05 * Constants.deviceHeight,
        decoration: BoxDecoration(
          color: AppColors.neutral_8,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SvgPicture.asset(
            path,
            width: 0.0064 * Constants.deviceWidth,
            height: 0.03 * Constants.deviceHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildTextSignUp() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account ?",
            style: AppStyles.smallText.copyWith(
              color: AppColors.primaryColor_1,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
              //print('Sign up button was pressed');
            },
            child: Text(" Sign up", style: AppStyles.smallText),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 0.08 * Constants.deviceHeight),
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 0.66 * Constants.deviceWidth,
        height: 0.15 * Constants.deviceHeight,
        fit: BoxFit.contain,
        color: AppColors.primaryColor_1,
      ),
    );
  }

  void handleLogin() async {
    setState(() {
      onProcess = true;
    });
    
    bool isLogin = await AuthService().loginByGoogle();

    setState(() {
      onProcess = false;
    });

    if (isLogin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBar(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Login failed'),
          );
        },
      );
    }
  }
}
