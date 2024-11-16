import 'package:flutter/material.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/styles/text_styles.dart';

class FilterButton extends StatefulWidget {
  final List<String> items;
  final Function(String) onSelected; // Uncommented the function

  FilterButton({
    required this.items,
    required this.onSelected, // Added this parameter
  });

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.neutral_3,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          value: selectedItem,
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppStyles.smallText.copyWith(
                  color: Color(0xFF000000),
                ),
              ),
            );
          }).toList(),
          icon: Icon(Icons.arrow_drop_down_outlined),
          onChanged: (item) {
            setState(() {
              selectedItem = item!;
            });
            widget.onSelected(selectedItem); // Call the onSelected function
          },
          underline: Container(),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
