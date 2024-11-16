import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_plan/styles/colors.dart';

class FieldInputMessage extends StatefulWidget {
  VoidCallback sendMessage;
  TextEditingController userInput;
  FieldInputMessage({
    super.key,
    required this.sendMessage,
    required this.userInput,
  });

  @override
  State<FieldInputMessage> createState() => _FieldInputMessageState();
}

class _FieldInputMessageState extends State<FieldInputMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:
                    const Color(0xff000000).withOpacity(0.13), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 20, // Blur radius
                offset: const Offset(5, 4), // Changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.userInput,
            decoration: InputDecoration(
              hintText: 'Write your Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 19, horizontal: 22),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: AppColors.primaryColor_1),
                onPressed: widget.sendMessage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
