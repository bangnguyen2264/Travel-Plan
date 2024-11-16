import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/widgets/appbar.dart';
import 'package:travel_plan/screens/list_place.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/utils/data.dart';
import 'package:travel_plan/widgets/top_place_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<HistoryScreen> {
  List<Locations> locations = [];
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'History',
        isBack: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                _buildTopPlacesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPlacesList() {
    return Container(
      margin: EdgeInsets.only(bottom: 83),
      child: Column(
        children: [
          // _buildTitleList('Top Places'),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 22),
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
      margin: EdgeInsets.symmetric(horizontal: 38),
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

  Future<void> getLocation() async {}
}
