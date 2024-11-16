import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/screens/list_place.dart';
import 'package:travel_plan/screens/notification.dart';
import 'package:travel_plan/screens/planning.dart';
import 'package:travel_plan/services/location_service.dart';
import 'package:travel_plan/services/user_service.dart';
import 'package:travel_plan/widgets/popular_place_card.dart';
import 'package:travel_plan/screens/acc_info.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:badges/badges.dart' as badges;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_plan/widgets/top_place_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentAddress = '';
  Position? currentPosition;
  static bool isFetching = false;
  Future<void> determinePosition() async {
    print(isFetching.toString());
    if (!isFetching) {
      try {
        setState(() {
          isFetching = true;
        });
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw Exception('Location services are disabled');
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            throw Exception('Location permissions is denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          throw Exception('Location permissions is denied forever');
        }

        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest,
          // timeLimit: const Duration(seconds: 10),
        );
        setState(() {
          currentPosition = position;
        });
        print('Position: $position');

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        print('Placemarks: $placemarks');
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String administrativeArea = place.administrativeArea
              .toString()
              .replaceAll("Thành phố", "")
              .trim();
          setState(() {
            currentAddress = "${administrativeArea}, ${place.isoCountryCode}";
          });
        } else {
          setState(() {
            currentAddress = "No address found";
          });
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('currentAddress', currentAddress);
      } catch (e) {
        print('Error fetching location: $e');
      }
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? address = prefs.getString('currentAddress');
      setState(() {
        currentAddress = address ?? 'No address found';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBoxLocation(),
            _buildAction(),
          ],
        ),
      ),
      body: FutureBuilder<List<Locations>?>(
        future: LocationService().getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 27),
                    _buildWelcome(),
                    _buildPlanningATC(),
                    _buildPopularPlacesList(snapshot.data!),
                    _buildTopPlacesList(snapshot.data!),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildBoxLocation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral_8,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              child: Image.asset(
                'assets/icons/location.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 9),
            Text(
              currentAddress,
              style: AppStyles.Body2.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBox() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -6, end: -4),
      showBadge: true,
      ignorePointer: false,
      badgeStyle: const badges.BadgeStyle(
        padding: EdgeInsets.all(5),
        shape: badges.BadgeShape.circle,
        badgeColor: Color(0xffFBBB00),
      ),
      badgeContent: Text(
        '3',
        style: AppStyles.smallText.copyWith(
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          print("Push to notification screen");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xffD4D4D4),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/icons/notification.png'),
        ),
      ),
    );
  }

  Widget _buildBoxAccount() {
    return FutureBuilder(
      future: UserService().getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final user = snapshot.data;
          return GestureDetector(
            onTap: () {
              print("Push to account screen");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreen(),
                ),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 50, // Độ lớn của avatar
                backgroundImage: NetworkImage(
                  user!.avatar,
                ), // Ảnh avatar
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildAction() {
    return Container(
      child: Row(
        children: [
          _buildNotificationBox(),
          const SizedBox(width: 17),
          _buildBoxAccount(),
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Discover the Best Travel Planning !',
        style: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 26,
        ),
      ),
    );
  }

  Widget _buildPlanningATC() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlanningScreen(),
          ),
        );
      },
      child: Container(
        height: 46,
        margin: const EdgeInsets.symmetric(horizontal: 31, vertical: 28),
        decoration: BoxDecoration(
          color: AppColors.primaryColor_1,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Start your trip',
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.search, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularPlacesList(List<Locations> locations) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleList('Popular'),
        Container(
          height: 218,
          margin: const EdgeInsets.only(left: 11),
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return PopularPlaceCard(location: locations[index]);
            },
          ),
        )
      ],
    );
  }

  Widget _buildTopPlacesList(List<Locations> locations) {
    return Container(
      margin: const EdgeInsets.only(bottom: 83),
      child: Column(
        children: [
          _buildTitleList('Top Places'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: TopPlaceCard(location: locations[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitleList(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 21,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPlace(title: title),
                ),
              );
            },
            child: Text(
              'See All',
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.primaryColor_1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
