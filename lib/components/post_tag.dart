import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';
import 'package:travel_plan/utils/const.dart';

class PostTag extends StatefulWidget {
  String title;
  String location;
  PostTag({
    super.key,
    required this.title,
    required this.location,
  });

  @override
  _PostTagState createState() => _PostTagState();
}

class _PostTagState extends State<PostTag> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 0.04 * Constants.deviceHeight,
        bottom: 0.03 * Constants.deviceHeight,
        right: 0.05 * Constants.deviceWidth,
        left: 0.05 * Constants.deviceWidth,
      ),
      width: Constants.deviceWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(), // Add spacing between icon and text
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 0.8 * Constants.deviceWidth,
                  child: AutoSizeText(
                    widget.title,
                    style: AppStyles.Heading3,
                    maxLines: 1,
                    minFontSize: 22,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5), // Add spacing between texts
                Container(
                  width: 0.8 * Constants.deviceWidth,
                  child: AutoSizeText(
                    widget.location,
                    maxLines: 1,
                    minFontSize: 18,
                    style: AppStyles.Body1.copyWith(
                      color: AppColors.neutral_6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 0.08 * Constants.deviceWidth,
                color: isFavorite ? Colors.red : AppColors.primaryColor_1,
              ),
              splashColor:
                  Colors.transparent, // Set splash color to transparent
              highlightColor:
                  Colors.transparent, // Set highlight color to transparent
            ),
          ),
        ],
      ),
    );
  }
}
