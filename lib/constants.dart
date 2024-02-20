import 'package:flutter/material.dart';
import 'package:get/get.dart';

const appName = "Eranou";
const warningColor = Colors.orange;
const errorColor = Colors.red;
const successColor = Colors.green;
const infoColor = Colors.indigo;
const google_api_key = "AIzaSyBbTebj7DVC2yJu0hDJPfqP63x9uz9GQ-8";

const easyMarketGreen = Color(0xFF900702E);
const easyMarketGreenLigth = Color(0xFF00EF44);
const easyMarketYellow = Color(0xfffacc22);
const easyMarketBleu = Color(0xFF7ECDDE);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const easymarketPrimaryColor = Color(0xFF900702E);

const defaultPadding = 12.0;
const circleAvatarRaduis = 75.0;

const defaultSizedBox = SizedBox(
  height: 10,
  width: 10,
);

const default2xSizedBox = SizedBox(
  height: 20,
  width: 20,
);

void returnError(String error) {
  Get.snackbar(
    "error".tr,
    error,
    colorText: Colors.white,
    backgroundColor: Colors.red,
  );
}

void returnSuccess(String success) {
  Get.snackbar(
    "success".tr,
    success,
    colorText: Colors.white,
    backgroundColor: Colors.green,
  );
}

// KKiaPay
String public_key = "b8ab8800a531d4fad4e282ed3c9ea3f78b7286a1";
String private_key =
    "pk_d0db75af8c452447f9b020cc251bd08930e55e4e53aef2880f623905190cda25";
String secret =
    "sk_061a182a4551eddcece391138eaaabd07337f8a3acfec29c5f6a7c8b1d5d20e5";
         