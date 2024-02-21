import 'dart:convert';

import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPassController extends GetxController {
  final email = ''.obs;
  final formKey = GlobalKey<FormState>();

  void setEmail(String value) {
    email.value = value;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Veuillez saisir votre adresse e-mail';
    } else if (!value.isEmail) {
      return 'Veuillez saisir un adresse e-mail valide';
    }
    return null;
  }

  void submitEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        final request = await http.post(Uri.parse(newPasswordUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email.value}));
        if (request.statusCode == 201 || request.statusCode == 200) {
          final response = jsonDecode(request.body);
          returnSuccess(response['message']);
          Get.snackbar('Email Soumis', 'Email: ${email.value}');
        } else {
          final response = jsonDecode(request.body);
          returnError(response['message']);
        }
      } catch (error) {
        throw Exception(
            "Error lors de l'envoie de mail!, l'erreur est: $error");
      }
    }
  }
}
