import 'dart:convert';

import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  String token = GetStorage().read('token').toString();
  String senderId = GetStorage().read('id').toString();
  String date = DateTime.now().toString();
  String nom = GetStorage().read('nom').toString() +
      GetStorage().read('prenom').toString();
  String transationID = '';
  Future<bool> sendMoney(String receiverPhone, int amount) async {
    try {
      transationID = senderId + date + nom;
      final body = jsonEncode({
        'userId': senderId,
        'amount': amount,
        'transactionId': transationID,
        'phone': receiverPhone
      });
      final request = await http.post(Uri.parse(sendMoneyUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);
      if (request.statusCode == 200 || request.statusCode == 201) {
        final response = json.decode(request.body);
        GetStorage().write('balance', response["transferDetails"]['senderBalance']);
        returnSuccess(response["transferDetails"]['message']);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Erreur lors de l\'envoie: $error');
    }
  }

  void navigateBack() => Get.back();
  TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  var phoneIsoCode;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  bool validateForm() {
    return formKey.currentState?.saveAndValidate() ?? false;
  }
}
