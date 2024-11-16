import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/models/plan_item.dart';
import 'package:travel_plan/models/planning.dart';
import 'package:travel_plan/screens/plan_details.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/format_string.dart';

class PlanResponse extends StatefulWidget {
  final Planning plan;

  PlanResponse({super.key, required this.plan});

  @override
  State<PlanResponse> createState() => _PlanResponseState();
}

class _PlanResponseState extends State<PlanResponse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 29),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: widget.plan.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          _buildplan(),
        ],
      ),
    );
  }

  Widget _buildplan() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(
          bottom: widget.plan.isUser ? 0 : 18,
          left: widget.plan.isUser ? 0 : 7,
        ),
        decoration: BoxDecoration(
          color: widget.plan.isUser
              ? AppColors.primaryColor_4
              : const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            bottomLeft:
                widget.plan.isUser ? const Radius.circular(25) : Radius.zero,
            topRight:
                widget.plan.isUser ? Radius.zero : const Radius.circular(25),
            bottomRight: const Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          child: widget.plan.isUser
              ? Text(
                  widget.plan.plan!.textUserInput,
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.plan.isUser ? Colors.white : Colors.black),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRowInforPlan(
                      'assets/icons/destination.svg',
                      widget.plan.plan!.destination,
                    ),
                    _buildRowInforPlan(
                      'assets/icons/timeclock.svg',
                      widget.plan.plan!.tourDuration!,
                    ),
                    _buildRowInforPlan(
                      'assets/icons/vehicle.svg',
                      widget.plan.plan!.vehicle!,
                    ),
                    _buildRowInforPlan(
                      'assets/icons/cost.svg',
                      formatInt(widget.plan.plan!.totalCostAvg!),
                    ),
                    _buildListCost(
                      'Vehicle: ',
                      widget.plan.plan!.vehicleCost!,
                    ),
                    _buildListCost(
                      'Eat: ',
                      widget.plan.plan!.foodCost!,
                    ),
                    _buildListCost(
                      'Play: ',
                      widget.plan.plan!.ticketCost!,
                    ),
                    _buildListCost(
                      'Room: ',
                      widget.plan.plan!.roomCost!,
                    ),
                    _buildListCost(
                      'Other: ',
                      widget.plan.plan!.otherCost!,
                    ),
                    Column(
                      children: widget.plan.plan!.planItems!
                          .map((planItem) => _buildListPlanItem(planItem))
                          .toList(),
                    ),
                    _buildTextMoreInfor(),
                  ],
                ),
        ),
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
            ),
          ),
          const SizedBox(
            width: 17,
          ),
          Container(
              child: Text(
            content,
            style: AppStyles.smallText.copyWith(
              color: AppColors.neutral_1,
              fontWeight: FontWeight.w500,
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildListCost(String title, int? cost) {
    return Container(
      width: Constants.deviceWidth * 0.45,
      margin: const EdgeInsets.only(left: 30),
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
            style: AppStyles.smallText.copyWith(
              color: AppColors.neutral_1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListPlanItem(PlanItem planItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.017 * Constants.deviceHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                    style: AppStyles.smallText.copyWith(fontSize: 10),
                  ),
                ),
                Container(
                  child: Text(
                    planItem.locationName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextMoreInfor() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanDetails(plan: widget.plan.plan!),
          ),
        ),
        child: Container(
          child: Text(
            'More information',
            style: AppStyles.smallText.copyWith(
              color: AppColors.primaryColor_4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
