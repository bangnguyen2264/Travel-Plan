import 'package:flutter/material.dart';
import 'package:travel_plan/components/place_infor.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/screens/place_detail.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/data.dart';

class TopPlaceCard extends StatefulWidget {
  final Locations location;
  TopPlaceCard({super.key, required this.location});

  @override
  State<TopPlaceCard> createState() => _TopPlaceCardState();
}

class _TopPlaceCardState extends State<TopPlaceCard> {
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
        margin: EdgeInsets.only(top: 0.01 * Constants.deviceHeight),
        height: 0.105 * Constants.deviceHeight,
        width: 0.9 * Constants.deviceWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.neutral_7,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(0.01 * Constants.deviceHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildImage(),
              _buildPlaceInfor(),
              _buildDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 0.16 * Constants.deviceWidth,
      height: 0.16 * Constants.deviceWidth,
      margin: EdgeInsets.only(right: 0.05 * Constants.deviceWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: NetworkImage(widget.location.imageUrl ?? emptyImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPlaceInfor() {
    return Container(
      width: 0.435 * Constants.deviceWidth,
      child: PlaceInfor(
        location: widget.location,
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      margin: EdgeInsets.only(left: 0.05 * Constants.deviceWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.neutral_8,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.location.rating.toString(),
                    style: AppStyles.smallText.copyWith(fontSize: 10),
                  ),
                  const Icon(
                    Icons.star,
                    size: 10,
                    color: Color(0xFFFFC14B),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor_1,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                'Details',
                style: AppStyles.smallText.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
