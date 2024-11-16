import 'package:flutter/material.dart';

class Validation{
  String? checkText(TextEditingController controller){
    if(controller.text.isEmpty){
      return 'This field is required';
    }
    return null;

  }
  String? checkPassword(TextEditingController controller){
    if(controller.text.isEmpty){
      return 'This field is required';
    }
    if(controller.text.length < 8){
      return 'Password must be at least 8 characters';
    }
    return null;
  }
  String? checkEmail(TextEditingController controller){
    if(controller.text.isEmpty){
      return 'This field is required';
    }
    if(!controller.text.contains('@') || !controller.text.contains('.')){
      return 'Invalid email';
    }
    return null;
  }
}