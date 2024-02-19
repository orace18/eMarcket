import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilController extends GetxController {
  void navigateBack() => Get.back();

  String nom = GetStorage().read('nom');
  String prenom = GetStorage().read('prenom');
  String phone = GetStorage().read('phone');
}
