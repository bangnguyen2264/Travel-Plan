import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/models/user.dart';
import 'package:travel_plan/services/user_service.dart';
import 'package:travel_plan/widgets/appbar.dart';

import 'package:travel_plan/screens/change_password.dart';
import 'package:travel_plan/screens/onboarding.dart';
import 'package:travel_plan/services/auth_service.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/widgets/avt_info_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final user = snapshot.data; // Access user data from snapshot
          return Scaffold(
            appBar: CustomAppBar(
              title: '${user?.firstName} ${user?.lastName}',
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0.05 * Constants.deviceHeight),
                Center(
                  child: EditableAvatar(
                    pathUrl: user!.avatar.toString(),
                  ),
                ),
                _buildBoxInfor('Personal', user: user),
                _buildBoxInfor('Contact', user: user),
                _buildListButton(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildBoxInfor(String key, {User? user}) {
    String? name = '${user?.lastName} ${user?.firstName}';
    return Container(
      margin: EdgeInsets.only(bottom: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$key Infor',
            style: TextStyle(
              fontSize: 16,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontWeight: FontWeight.w700,
              color: Color(0xff6B7280),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: 0.872 * Constants.deviceWidth,
            height: 0.138 * Constants.deviceHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xfffF3F4F6),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRow(
                  key == 'Personal' ? 'Your name' : 'Phone number',
                  key == 'Personal' ? name ?? "N/A" : user?.phone ?? "N/A",
                ),
                _buildRow(
                  key == 'Personal' ? 'Username' : 'Email',
                  key == 'Personal'
                      ? user?.username ?? "N/A"
                      : user?.email ?? "N/A",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontWeight: FontWeight.w600,
              color: Color(0xff6B7280),
            ),
          ),
          SizedBox(width: 8), // Add space between label and value
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontWeight: FontWeight.w600,
              color: Color(0xff1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListButton() {
    return Container(
      width: 0.87 * Constants.deviceWidth,
      height: 0.14 * Constants.deviceHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xfffF3F4F6),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              );
            },
            child: Text(
              'Change Password',
              style: TextStyle(
                fontSize: 14,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w600,
                color: Color(0xffFFFFFF),
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 0.236 * Constants.deviceWidth,
                vertical: 0.016 * Constants.deviceHeight,
              ),
              backgroundColor: Color(0xffFBBB00),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
            ),
          ),
          SizedBox(height: 0.01 * Constants.deviceHeight),
          ElevatedButton(
            onPressed: () {
              AuthService().logout();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingSreen(),
                ),
              );
            },
            child: Text(
              'Log out',
              style: TextStyle(
                fontSize: 14,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w600,
                color: Color(0xffFFFFFF),
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 0.327 * Constants.deviceWidth,
                vertical: 0.016 * Constants.deviceHeight,
              ),
              backgroundColor: Color(0xffED0006),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
