import 'package:travel_plan/models/plan.dart';

class Planning
{
  final bool isUser;
  final Plan? plan;
  const Planning({
    required this.isUser,
    this.plan,
  });
}