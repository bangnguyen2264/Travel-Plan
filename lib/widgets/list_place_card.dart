import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/screens/place_detail.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';

class PlaceCard extends StatefulWidget {
  final Locations location;
  const PlaceCard({Key? key, required this.location}) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavorite = false;

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
        margin: EdgeInsets.symmetric(horizontal: 0.01 * Constants.deviceWidth)
            .copyWith(right: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE6E8EC),
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 0.032 * Constants.deviceWidth,
            vertical: 0.02 * Constants.deviceHeight,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(),
                  _buildRating(),
                ],
              ),
              _buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 0.25 * Constants.deviceHeight,
      width: 0.768 * Constants.deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: Image.network(widget.location.imageUrl ?? '').image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Container(
      margin: EdgeInsets.only(left: 0.0135 * Constants.deviceWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 0.04 * Constants.deviceWidth,
              color: isFavorite ? Colors.red : AppColors.primaryColor_1,
            ),
            splashColor: Colors.transparent, // Set splash color to transparent
            highlightColor:
                Colors.transparent, // Set highlight color to transparent
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.neutral_8,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.location.rating.toString(),
                style: AppStyles.smallText.copyWith(
                  color: AppColors.neutral_2,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          RatingBar.readOnly(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            halfFilledIcon: Icons.star_half,
            direction: Axis.vertical,
            isHalfAllowed: true,
            initialRating: widget.location.rating,
            maxRating: 5,
            filledColor: Color(0xFFE67136),
            emptyColor: Color(0xFFE3E3E3),
            halfFilledColor: Color(0xFFE67136),
            size: 0.04 * Constants.deviceWidth,
          )
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0.02 * Constants.deviceHeight,
      ),
      width: 0.9 * Constants.deviceWidth,
      child: Text(
        widget.location.description ?? '',
        style: AppStyles.Body2,
        textAlign: TextAlign.justify,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
