import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/models/location_details.dart';
import 'package:travel_plan/models/plan.dart';
import 'package:travel_plan/models/plan_item.dart';
import 'package:travel_plan/screens/place_detail.dart';
import 'package:travel_plan/services/location_service.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/data.dart';
import 'package:travel_plan/utils/format_string.dart';
import 'package:travel_plan/widgets/appbar.dart';

class PlanDetails extends StatefulWidget {
  final Plan plan;
  const PlanDetails({
    super.key,
    required this.plan,
  });

  @override
  State<PlanDetails> createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Plan Details',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 0.015 * Constants.deviceHeight,
          horizontal: 0.05 * Constants.deviceWidth,
        ),
        child: ListView(
          children: [
            _buildPlanDetails(),
            _buildListInfor(),
            buildImage1(
              'assets/images/Rectangle-4389.png',
              'assets/images/Card-04.png',
            ),
            buildImage2('assets/images/Rectangle-4392.png'),
            Column(
              children: widget.plan.planItems!
                  .map((planItem) => _buildListPlanItem(planItem))
                  .toList(),
            ),
            _buildRowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanDetails() {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/plan_details_bg.svg',
            width: 0.9 * Constants.deviceWidth,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/circle.svg',
                    width: 0.048 * Constants.deviceWidth,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: AutoSizeText(
                  'Du lịch ${widget.plan.destination}',
                  style: AppStyles.Body1.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  minFontSize: 14,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/circle.svg',
                    width: 0.021 * Constants.deviceWidth,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListInfor() {
    return Container(
      padding: EdgeInsets.all(0.04 * Constants.deviceWidth),
      margin: EdgeInsets.only(
        top: 0.038 * Constants.deviceHeight,
        bottom: 0.02 * Constants.deviceHeight,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.neutral_6,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildRowInforPlan(
                  'assets/icons/destination.svg',
                  widget.plan.destination,
                ),
                _buildRowInforPlan(
                  'assets/icons/timeclock.svg',
                  widget.plan.tourDuration!,
                ),
              ],
            ),
          ),
          SizedBox(width: 0.005 * Constants.deviceWidth),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildRowInforPlan(
                  'assets/icons/vehicle.svg',
                  widget.plan.vehicle!,
                ),
                _buildRowInforPlan(
                  'assets/icons/cost.svg',
                  formatInt(widget.plan.totalCostAvg!),
                ),
                _buildListCost(
                  'Vehicle: ',
                  widget.plan.vehicleCost!,
                ),
                _buildListCost(
                  'Eat: ',
                  widget.plan.foodCost!,
                ),
                _buildListCost(
                  'Play: ',
                  widget.plan.ticketCost!,
                ),
                _buildListCost(
                  'Room: ',
                  widget.plan.roomCost!,
                ),
                _buildListCost(
                  'Other: ',
                  widget.plan.otherCost!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowInforPlan(String pathIcon, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            child: SvgPicture.asset(
              pathIcon,
              width: 16,
              height: 16,
              color: AppColors.primaryColor_1,
            ),
          ),
          const SizedBox(
            width: 17,
          ),
          Container(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCost(String title, int? cost) {
    return Container(
      //     width: Constants.deviceWidth * 0.45,
      margin: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.smallText.copyWith(
              color: AppColors.neutral_1,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${cost.toString()} VND',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage1(String path1, String path2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 0.41 * Constants.deviceWidth,
          height: 0.18 * Constants.deviceHeight,
          child: Image.asset(
            path1,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 0.04 * Constants.deviceWidth),
        Container(
          width: 0.41 * Constants.deviceWidth,
          height: 0.18 * Constants.deviceHeight,
          child: Image.asset(
            path2,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget buildImage2(String path) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.018 * Constants.deviceHeight),
      width: Constants.deviceWidth,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildListPlanItem(PlanItem planItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlaceDetailScreen(locationId: planItem.locationId),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.018 * Constants.deviceHeight),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ngày ',
                  style: AppStyles.smallText,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFF0101),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      planItem.numberDay.toString(),
                      style: AppStyles.smallText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 7),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '${planItem.timeStart}-${planItem.timeClose}',
                          style: AppStyles.smallText.copyWith(fontSize: 12),
                        ),
                      ),
                      Container(
                        child: Text(
                          planItem.locationName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            _buildRowDiscribtionPlanItem(planItem.locationId),
          ],
        ),
      ),
    );
  }

  Widget _buildRowDiscribtionPlanItem(String id) {
    return FutureBuilder(
      future: LocationService().getLocationDetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.hasData) {
          final location = snapshot.data as LocationDetails;
          return Container(
            margin: EdgeInsets.only(top: 0.05 * Constants.deviceWidth),
            child: Row(
              children: [
                Container(
                  width: 0.3 * Constants.deviceWidth,
                  height: 0.1 * Constants.deviceHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      location.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 0.05 * Constants.deviceWidth),
                Container(
                  width: 0.5 * Constants.deviceWidth,
                  child: Text(
                    location.description ?? '',
                    style: AppStyles.smallText.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            width: 0.3 * Constants.deviceWidth,
            height: 0.1 * Constants.deviceWidth,
            child: Image.network(
              emptyImage,
              fit: BoxFit.contain,
            ),
          );
        }
      },
    );
  }

  Widget _buildRowButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              'More Details',
              style: AppStyles.smallText.copyWith(
                fontSize: 14,
                color: AppColors.primaryColor_1,
              ),
            ),
          ),
          SizedBox(width: 0.032 * Constants.deviceWidth),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Apply This Trip',
              style: AppStyles.smallText.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor_1,
              padding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
