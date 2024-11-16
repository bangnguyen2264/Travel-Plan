import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_plan/utils/format_string.dart';
import 'package:travel_plan/utils/global.dart';

class AuthService {
  Future<bool> loginByGoogle() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
     if (googleAccount == null) {
      print('Login with Google failed');
      return false;
    }

    final googleAuth = await googleAccount.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('credential: $credential');

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      if (userCredential.user?.email != null &&
          userCredential.user?.displayName != null) {
        final Map<String, dynamic> requestBody = {
          'username': userCredential.user!.email,
          'email': userCredential.user!.email,
          'firstName': getFirstName(userCredential.user!.displayName!),
          'lastName': getLastName(userCredential.user!.displayName!),
          'avatar': userCredential.user!.photoURL ,
        };
        print('Request body: ${jsonEncode(requestBody)}');
        final response = await http.post(
          Uri.parse('$baseUrl/user/access/api/v1/auth/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );
        if (response.statusCode == 200) {
          print('Login success with Google: ${response.body}');
          await saveToken(response.body);
          return true;
        } else {
          print("Error: ${response.statusCode} - ${response.body}");
        }
      }
    } catch (e) {
      print('Exception while login with Google: $e');
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    final googleSignIn = GoogleSignIn();
    final firebaseAuth = FirebaseAuth.instance;

    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    print('Logout completed');
  }

  Future<void> saveToken(String responseBody) async {
    try {
      final Map<String, dynamic> responseData = jsonDecode(responseBody);

      if (responseData.containsKey('accessToken')) {
        final String accessToken = 'Bearer ${responseData['accessToken']}';
        print("Access Token: $accessToken");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', accessToken);
        print('Save token completed');
      }
    } catch (e) {
      print("Exception while saving token: $e");
    }
  }

 
}
