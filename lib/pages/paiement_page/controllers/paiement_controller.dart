import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/helpers/constants.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:easy_market_client/helpers/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:kkiapay_flutter_sdk/utils/config.dart';

class PaiementController extends GetxController {

  final id = GetStorage().read('id').toString();
  String token = GetStorage().read('token').toString();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var phoneIsoCode;

  Future<void> makeRecharge(int montant, String transactionId) async {
    String pays = phoneIsoCode.toString();
    try {
      final request = await http.post(
        Uri.parse(chargeWalletUrl),
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'userId': id,
          'amount': montant,
          'transactionId': transactionId,
          'email': emailController.text,
          'reason': reasonController.text,
          'country': pays,
          'phone': phoneNumberController.text
        }),
      );
      if (request.statusCode == 200 || request.statusCode == 201) {
        final response = json.decode(request.body);
        GetStorage().write('balance', response['balance'] ?? '00');
        returnSuccess(response['message']);
      } else {
        final response = json.decode(request.body);
        returnError(response['message']);
      }
    } catch (error) {
      throw Exception("Exception $error");
    }
  }

  void successCallback(response, context) {
    switch (response['status']) {
      case PAYMENT_CANCELLED:
        debugPrint(PAYMENT_CANCELLED);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PAYMENT_CANCELLED),
        ));
        break;

      case PENDING_PAYMENT:
        debugPrint(PENDING_PAYMENT);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PENDING_PAYMENT),
        ));
        break;

      case PAYMENT_INIT:
        debugPrint(PAYMENT_INIT);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PAYMENT_INIT),
        ));
        break;

      case PAYMENT_SUCCESS:
        print("$response");
        makeRecharge(
            response['requestData']['amount'], response['transactionId']);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              amount: response['requestData']['amount'],
              transactionId: response['transactionId'],
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(PAYMENT_SUCCESS),
        ));
        break;

      case PAYMENT_FAILED:
        debugPrint(PAYMENT_FAILED);
        break;

      default:
        break;
    }
  }

  String nomPrenom = GetStorage().read("nom").toString() +
      ' ' +
      GetStorage().read("prenom").toString();

  Widget openKkiapayPayment() {
    String pays = phoneIsoCode.toString();
    int montant = int.parse(amountController.text.toString());
    final kkiapay = KKiaPay(
        amount: montant,
        countries: [pays],
        phone: phoneNumberController.text,
        name: nomPrenom,
        email: emailController.text,
        reason: reasonController.text,
        sandbox: false,
        apikey: "b8ab8800a531d4fad4e282ed3c9ea3f78b7286a1",
        callback: successCallback,
        theme: "#008000",
        paymentMethods: ["momo", "card"]);
    return kkiapay;
  }
}