import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/services/location_service.dart';
import 'package:travel_plan/widgets/appbar.dart';
import 'package:travel_plan/components/search.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/widgets/filter.dart';
import 'package:travel_plan/widgets/list_place_card.dart';

class ListPlace extends StatefulWidget {
  final String title;
  const ListPlace({super.key, required this.title});

  @override
  State<ListPlace> createState() => _ListPlaceState();
}

class _ListPlaceState extends State<ListPlace> {
  List<Locations> locations = [];
  //TODO: Add funtion and codition to call api for top and popular place
  List<String> place = [
    'Place 1',
    'Place 2',
    'Place 3',
    'Place 4',
  ];
  List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
  ];
  //TODO: Add function to get the selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${widget.title} Places',
        action: SearchButton(),
      ),
      body: FutureBuilder(
        future: LocationService().getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor_1,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }
          locations = snapshot.data as List<Locations>;
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 21, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FilterButton(items: place, onSelected: (String value) {}),
                      SizedBox(width: 14),
                      FilterButton(
                        items: categories,
                        onSelected: (String value) {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      return PlaceCard(location: locations[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
