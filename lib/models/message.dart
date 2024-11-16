import 'package:travel_plan/models/plan.dart';

class Message {
  final bool isUser;
  final String content;
  final Plan? plan;

  Message({
    required this.isUser,
    required this.content,
    this.plan,
  });
}
