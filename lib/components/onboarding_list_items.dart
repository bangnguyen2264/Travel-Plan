import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/screens/login.dart';
import 'package:travel_plan/screens/signup.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_plan/utils/const.dart';

class OnboardingList extends StatefulWidget {
  final List<String> items;
  final PageController pageController;

  OnboardingList({
    required this.items,
    required this.pageController,
  });

  @override
  _OnboardingListState createState() => _OnboardingListState();
}

class _OnboardingListState extends State<OnboardingList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 0.4 * Constants.deviceHeight,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return OnboardingItem(
                item: widget.items[index],
                currentIndex: index,
                lastIndex: widget.items.length - 1,
              );
            },
          ),
        ),
        DotOboarding(
          pageController: widget.pageController,
          itemCount: widget.items.length,
        ),
      ],
    );
  }
}

class OnboardingItem extends StatelessWidget {
  final String item;
  final int currentIndex;
  final int lastIndex;

  OnboardingItem({
    required this.item,
    required this.currentIndex,
    required this.lastIndex,
  });

  bool isLastItem() {
    return currentIndex == lastIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 293,
              margin: EdgeInsets.only(
                bottom: !isLastItem() ? 0.174 * Constants.deviceHeight : 0,
              ),
              child: Text(
                item,
                maxLines: 3,
                style: AppStyles.Body1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        if (currentIndex == lastIndex) _buildNavigateButton(context),
      ],
    );
  }
}

class DotOboarding extends StatelessWidget {
  final PageController pageController;
  final int itemCount;

  const DotOboarding({
    required this.pageController,
    required this.itemCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0.047 * Constants.deviceHeight),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: itemCount,
                  effect: const ExpandingDotsEffect(
                    dotColor: Color(0xFF352555),
                    activeDotColor: AppColors.primaryColor_1,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 2.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildNavigateButton(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 0.075 * Constants.deviceHeight,
      bottom: 0.088 * Constants.deviceHeight,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.primaryColor_1),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(0.043 * Constants.deviceWidth),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0.04 * Constants.deviceWidth),
              ),
            ),
          ),
        ),
        SizedBox(width: 0.05 * Constants.deviceWidth),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupScreen(),
              ),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 16,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor_1,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(0.05 * Constants.deviceWidth),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0.05 * Constants.deviceWidth),
                side: BorderSide(
                  color: AppColors.primaryColor_1,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
