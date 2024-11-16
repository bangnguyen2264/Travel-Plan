import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_plan/components/login_item.dart';
import 'package:travel_plan/models/message.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/utils/format_string.dart';

class Messages extends StatelessWidget {
  final Message message;

  const Messages({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 29),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) _buildBot(),
          _buildMessage(),
        ],
      ),
    );
  }

  Widget _buildBot() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          "assets/icons/bot.png",
          color: AppColors.primaryColor_1,
          width: 15,
          height: 15,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(
          bottom: message.isUser ? 0 : 18,
          left: message.isUser ? 0 : 7,
        ),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primaryColor_4 : Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: message.isUser ? Radius.circular(25) : Radius.zero,
            topRight: message.isUser ? Radius.zero : Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          child: Text(
            message.content,
            style: TextStyle(
                fontSize: 16,
                color: message.isUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
