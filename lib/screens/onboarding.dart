import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_plan/components/onboarding_list_items.dart';
import 'package:travel_plan/layout/onboarding_background.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/styles/colors.dart';

class OnboardingSreen extends StatefulWidget {
  const OnboardingSreen({super.key});

  @override
  State<OnboardingSreen> createState() => _OnboardingSreenState();
}

class _OnboardingSreenState extends State<OnboardingSreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> onboardingItems = [
      'Discover the world with ease - plan your adventures and find the perfect accommodations...',
      'All in one place with TravelPlan app!',
    ];

    final int itemCount = onboardingItems.length;

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.primaryColor_1,
    // ));

    return Scaffold(
      body: Stack(
        children: [
          OnboardingBackground(),
          OnboardingList(
            items: onboardingItems,
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}
