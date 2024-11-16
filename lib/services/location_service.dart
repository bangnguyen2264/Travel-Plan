import 'dart:convert';

import 'package:travel_plan/models/location.dart';
import 'package:travel_plan/models/location_details.dart';
import 'package:travel_plan/services/api_service.dart';
import 'package:travel_plan/utils/global.dart';

class LocationService {
  Future<List<Locations>?> getLocation() async {
    try {
      final response = await ApiService().getList(
          '$baseUrl/location/access/api/v1/locations?pageNo=0&pageSize=2000&sortBy=id&sortDir=asc');

      if (response == null) throw Exception('Failed to load data');
      print('Response: ${response}');
      final jsonList =
          response.map((json) => Locations.fromJson(json)).toList();
      print('jsonList: $jsonList');
      return jsonList;
    } catch (e) {
      throw Exception('Error exception at LocationService.getLocation: $e');
    }
  }

  Future<LocationDetails?> getLocationDetails(String id) async {
    try {
      final response = await ApiService()
          .get('$baseUrl/location/access/api/v1/locations/$id');
      if (response == null) throw Exception('Failed to load data');
      return LocationDetails.fromJson(response);
    } catch (e) {
      throw Exception(
          'Error exception at LocationService.getLocationDetails: $e');
    }
  }
}
