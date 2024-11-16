import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/components/place_infor.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/screens/place_detail.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/data.dart';

class PopularPlaceCard extends StatefulWidget {
  Locations location;

  PopularPlaceCard({super.key, required this.location});
  @override
  State<PopularPlaceCard> createState() => _PopularPlaceCardState();
}

class _PopularPlaceCardState extends State<PopularPlaceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlaceDetailScreen(locationId: widget.location.id);
            },
          ),
        );
        print('Tapped');
      },
      child: Container(
        height: 0.27 * Constants.deviceHeight,
        width: 0.45 * Constants.deviceWidth,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(widget.location.imageUrl ?? emptyImage),
              fit: BoxFit.cover,
            )),
        child: Container(
          margin: EdgeInsets.only(top: 143, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2).withOpacity(0.8),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6, left: 8),
                      child: PlaceInfor(location: widget.location),
                    ),
                    Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(left: 125),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.accentColor_2,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
