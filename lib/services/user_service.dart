import 'package:travel_plan/models/user.dart';
import 'package:travel_plan/services/api_service.dart';
import 'package:travel_plan/utils/global.dart';

class UserService {
  Future<User> getUser() async {
      final response = await ApiService().get ('$baseUrl/user/secured/api/v1/user/me');
      return User.fromJson(response!);
  }
}