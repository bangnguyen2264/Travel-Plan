import 'dart:ffi';

import 'package:travel_plan/models/plan.dart';
import 'package:travel_plan/services/api_service.dart';
import 'package:travel_plan/utils/global.dart';

class PlanService{
  Future<Plan> generatePlan(String destination,String text) async {
    final body = {
      'destination': destination,
      'text': text,
    };
    final response = await ApiService().post('$baseUrl/gemini/api/v1/generate-plan', body);
    print('Response: $response');
    return Plan.fromJson(response);
    
  }
}