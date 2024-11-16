import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/format_string.dart';

class PlaceInfor extends StatelessWidget {
  final Locations location;
  const PlaceInfor({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            location.name!,
            style: AppStyles.Heading1.copyWith(
              color: AppColors.neutral_1,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 4),
                child: SvgPicture.asset(
                  'assets/icons/location.svg',
                  width: 0.01 * Constants.deviceHeight,
                  height: 0.01 * Constants.deviceHeight,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                location.province!,
                style: AppStyles.Subtitle.copyWith(
                  color: AppColors.neutral_5,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('${formatInt(location.ratingCount)} / ',
                  style: AppStyles.Subtitle.copyWith(
                    color: AppColors.neutral_4,
                    fontSize: 10,
                  )),
              Container(
                margin: EdgeInsets.only(top: 2),
                width: 9,
                height: 9,
                child: SvgPicture.asset(
                  'assets/icons/person.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
