import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  final email = ''.obs;
  final formKey = GlobalKey<FormState>();

  void setEmail(String value) {
    email.value = value;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Veuillez saisir votre adresse e-mail';
    }
    // Ajoutez des validations d'email supplémentaires si nécessaire
    return null;
  }

  void submitEmail() {
    if (formKey.currentState!.validate()) {
      
      Get.snackbar('Email Soumis', 'Email: ${email.value}');
    }
  }
}
