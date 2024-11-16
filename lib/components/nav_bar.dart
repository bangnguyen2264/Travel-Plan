import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/screens/bot.dart';
import 'package:travel_plan/screens/history.dart';
import 'package:travel_plan/screens/home.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/utils/const.dart';

class NavBar extends StatefulWidget {
  final int? directionIndex;
  const NavBar({super.key, this.directionIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  late int currentIndex;
  final List<Widget> tabList = [
    HomeScreen(),
    HistoryScreen(),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    currentIndex = widget.directionIndex ?? 0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          tabList.elementAt(currentIndex),
          if (!isKeyboardVisible)
            Padding(
              padding: EdgeInsets.all(0.02 * Constants.deviceWidth),
              child: Align(
                alignment: const Alignment(0.0, 1.0),
                child: Container(
                  height: 0.08 * Constants.deviceHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 38,
                        offset: Offset(0, -19),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: BottomNavigationBar(
                      items: [
                        _buildBottomNavigationBarItem(
                          '',
                          'assets/icons/home.svg',
                          0,
                        ),
                        _buildBottomNavigationBarItem(
                          '',
                          'assets/icons/cart.svg',
                          1,
                        ),
                      ],
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      onTap: (int index) {
                        if (mounted) {
                          setState(() {
                            currentIndex = index;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0.04 * Constants.deviceHeight,
            left: 0.4 * Constants.deviceWidth,
            child: _buildCircleBot(),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String label, String iconPath, int index) {
    return BottomNavigationBarItem(
      label: label,
      icon: Container(
        width: 25,
        height: 25,
        child: SvgPicture.asset(
          iconPath,
          width: 25,
          height: 25,
          color: currentIndex == index
              ? AppColors.primaryColor_1
              : AppColors.neutral_7,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCircleBot() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BotScreen(),
          ),
        );
        print('Push to bot screen');
      },
      child: Container(
        alignment: Alignment.center,
        width: 0.2 * Constants.deviceWidth,
        height: 0.092 * Constants.deviceHeight,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor_1,
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/bot.svg',
            width: 0.075 * Constants.deviceWidth,
            height: 0.075 * Constants.deviceWidth,
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
