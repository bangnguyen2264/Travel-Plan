import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/components/post_tag.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_plan/models/location_details.dart';
import 'package:travel_plan/services/location_service.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/format_string.dart';

import '../widgets/appbar.dart';

class PlaceDetailScreen extends StatefulWidget {
  String locationId;
  PlaceDetailScreen({
    super.key,
    required this.locationId,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  LocationDetails? locationDetails;
  String generateAddressText(Address address) {
    String addressText = '';
    if (address.street != null) {
      addressText += 'Đường ' + address.street! + ', ';
    }
    if (address.ward != null) {
      addressText += address.ward! + ', ';
    }
    if (address.district != null) {
      addressText += address.district! + ', ';
    }
    if (address.province != null) {
      addressText += address.province! + ', ';
    }
    if (address.country != null) {
      addressText += address.country!;
    }
    return addressText;
  }

  @override
  void initState() {
    LocationService().getLocationDetails(widget.locationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Thông tin địa điểm'),
        body: FutureBuilder(
          future: LocationService().getLocationDetails(widget.locationId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              locationDetails = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostTag(
                      title: locationDetails!.name!,
                      location: locationDetails!.address!.province,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 0.018 * Constants.deviceHeight,
                        horizontal: 0.067 * Constants.deviceWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildGroupImage(),
                          SizedBox(height: 30),
                          Text(
                            locationDetails!.description!,
                            style: TextStyle(fontSize: 16),
                          ),
                          //Thêm thông tin địa điểm
                          buildContent(locationDetails!.content!),
                          // Thêm thông tin liên hệ
                          if (locationDetails!.contact!.phoneNumber != null)
                            buildContactInfor(
                              'assets/icons/phone.svg',
                              locationDetails!.contact!.phoneNumber!,
                            ),
                          if (locationDetails!.contact!.email != null)
                            buildContactInfor(
                              'assets/icons/mail.svg',
                              locationDetails!.contact!.email!,
                            ),
                          if (locationDetails!.contact!.website != null)
                            buildContactInfor(
                              'assets/icons/web.svg',
                              locationDetails!.contact!.website!,
                            ),
                          if (locationDetails!.contact!.facebook != null)
                            buildContactInfor(
                              'assets/icons/facebook.svg',
                              locationDetails!.contact!.facebook!,
                            ),
                          if (locationDetails!.openingHoursDay != null)
                            buildContactInfor(
                              'assets/icons/time.svg',
                              locationDetails!.openingHoursDay!,
                            ),
                          if (locationDetails!.maxCost != null)
                            buildContactInfor(
                              'assets/icons/money.svg',
                              '${formatInt(locationDetails!.maxCost!)}/ người',
                            ),
                          if (generateAddressText(locationDetails!.address!) !=
                              '')
                            buildContactInfor(
                              'assets/icons/location.svg',
                              generateAddressText(locationDetails!.address!),
                            ),
                          SizedBox(height: 20), // Thêm một khoảng cách
                          buildRatingBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget buildGroupImage() {
    return Container(
      child: Column(
        children: [
          buildImage1(
            locationDetails!.imageUrls![0],
            locationDetails!.imageUrls![1],
          ),
          buildImage2(locationDetails!.imageUrls![2]),
          buildImage3(
            locationDetails!.imageUrls![3],
            locationDetails!.imageUrls![4],
          ),
        ],
      ),
    );
  }

  Widget buildContent(String description) {
    return Text(
      description,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget buildImage1(String path1, String path2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 0.41 * Constants.deviceWidth,
          height: 0.18 * Constants.deviceHeight,
          child: Image.network(
            path1,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 0.04 * Constants.deviceWidth),
        Container(
          width: 0.41 * Constants.deviceWidth,
          height: 0.18 * Constants.deviceHeight,
          child: Image.network(
            path2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget buildImage2(String path) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.018 * Constants.deviceHeight),
      width: Constants.deviceWidth,
      child: Image.network(
        path,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildImage3(String path1, String path2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 0.41 * Constants.deviceWidth,
          height: 0.3 * Constants.deviceHeight,
          child: Image.network(
            path1,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 0.04 * Constants.deviceWidth),
        Container(
          width: 0.41 * Constants.deviceWidth,
          height: 0.3 * Constants.deviceHeight,
          child: Image.network(
            path2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget buildContactInfor(String path, String infor) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.001 * Constants.deviceHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 0.027 * Constants.deviceWidth,
              top: 0.005 * Constants.deviceHeight,
            ),
            child: SvgPicture.asset(
              path,
              width: 12,
              height: 12,
              color: AppColors.primaryColor_1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 0.03 * Constants.deviceWidth),
          Container(
            width: 0.72 * Constants.deviceWidth,
            child: Text(
              infor,
              style: AppStyles.smallText,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatingBar() {
    return Container(
      height: 0.13 * Constants.deviceHeight,
      width: 0.888 * Constants.deviceWidth,
      padding: EdgeInsets.only(
        top: 0.025 * Constants.deviceHeight,
        left: 0.043 * Constants.deviceWidth,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.neutral_7,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add your rate and reviews!',
              style: AppStyles.Body2.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.neutral_1,
              )),
          SizedBox(height: 8),
          RatingBar.builder(
            initialRating: locationDetails!.rating!.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 30,
            unratedColor: Colors.grey,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
    );
  }
}
