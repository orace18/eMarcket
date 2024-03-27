import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilController extends GetxController {
  void navigateBack() => Get.back();

  String nom = GetStorage().read('nom');
  String prenom = GetStorage().read('prenom');
  String phone = GetStorage().read('phone');


  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  bool validateForm() {
    return formKey.currentState?.saveAndValidate() ?? false;
  }
}
