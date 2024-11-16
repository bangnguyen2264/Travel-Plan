import 'package:travel_plan/models/plan_item.dart';

class Plan {
  final String? id;
  final String textUserInput;
  final String? title;
  final String destination;
  final String? tourDuration;
  final String? description;
  final String? vehicle;
  final int? totalCostAvg;
  final int? vehicleCost;
  final int? roomCost;
  final int? foodCost;
  final int? ticketCost;
  final int? otherCost;
  final String? username;
  final List<PlanItem>? planItems;

  Plan({
    this.id,
    required this.textUserInput,
    this.title,
    required this.destination,
    this.tourDuration,
    this.description,
    this.vehicle,
    this.totalCostAvg,
    this.vehicleCost,
    this.roomCost,
    this.foodCost,
    this.ticketCost,
    this.otherCost,
    this.username,
    this.planItems,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      textUserInput: json['textUserInput'] ?? '',
      title: json['title'] ?? '',
      destination: json['destination'] ?? '',
      tourDuration: json['tourDuration'] ?? '',
      description: json['description'] ?? '',
      vehicle: json['vehicle'] ?? '',
      totalCostAvg: json['totalCostAvg'],
      vehicleCost: json['vehicleCost'],
      roomCost: json['roomCost'],
      foodCost: json['foodCost'],
      ticketCost: json['ticketCost'],
      otherCost: json['otherCost'],
      username: json['username'],
      planItems: List<PlanItem>.from(
          json['planItems'].map((item) => PlanItem.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'textUserInput': textUserInput,
      'title': title,
      'destination': destination,
      'tourDuration': tourDuration,
      'description': description,
      'vehicle': vehicle,
      'totalCostAvg': totalCostAvg,
      'vehicleCost': vehicleCost,
      'roomCost': roomCost,
      'foodCost': foodCost,
      'ticketCost': ticketCost,
      'otherCost': otherCost,
      'username': username,
      'planItems': planItems?.map((item) => item.toJson()).toList(),
    };
  }
}
