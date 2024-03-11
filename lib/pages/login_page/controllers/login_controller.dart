import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  void navigateBack() => Get.back();
  TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var phoneIsoCode;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  bool validateForm() {
    return formKey.currentState?.saveAndValidate() ?? false;
  }

}
