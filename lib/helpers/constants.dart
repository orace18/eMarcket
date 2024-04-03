import 'package:flutter/material.dart';
import 'package:get/get.dart';

const appName = "Er@nou";
const warningColor = Colors.orange;
const errorColor = Colors.red;
const successColor = Colors.green;
const infoColor = Colors.indigo;
const google_api_key = "AIzaSyBbTebj7DVC2yJu0hDJPfqP63x9uz9GQ-8";
const montantByKm = 0;
const easyMarketGreen = Color(0xFFF7ECEC);
const easyMarketGreenLigth = Color(0xFF00EF44);
const easyMarketYellow = Color(0xfffacc22);
const easyMarketBleu = Color(0xFFF7ECEC);
const primaryColor = Color(0xFF2A4A61);

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


