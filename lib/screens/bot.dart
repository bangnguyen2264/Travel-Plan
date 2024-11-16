import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:travel_plan/components/arrow_back.dart';
import 'package:travel_plan/models/message.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/global.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/widgets/bot_messages.dart';
import 'package:travel_plan/widgets/field_input_message.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  static bool isResponse = false;
  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userInput.text;
    if (message.isEmpty) {
      return;
    }

    setState(() {
      isResponse = true;
      _messages.add(Message(isUser: true, content: message));
    });
    _userInput.clear();
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
        isUser: false,
        content: response.text ?? "",
      ));
      isResponse = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leadingWidth: 64,
        leading: const ArrowBack(),
        title: _buildTitleAppbar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 76),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return Messages(message: _messages[index]);
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: FieldInputMessage(
                    sendMessage: sendMessage,
                    userInput: _userInput,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAppbar() {
    return Container(
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 17),
              child: SvgPicture.asset(
                'assets/icons/bot.svg',
                color: AppColors.primaryColor_1,
                width: 0.1 * Constants.deviceWidth,
                height: 0.1 * Constants.deviceWidth,
                fit: BoxFit.contain,
              )),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TravelBot',
                style: TextStyle(
                  color: AppColors.primaryColor_1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 6,
                    color: AppColors.correctColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: AppColors.correctColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
