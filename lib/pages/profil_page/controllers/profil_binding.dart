import 'package:easy_market_client/pages/profil_page/controllers/profil_controller.dart';
import 'package:get/get.dart';

class ProfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(() => ProfilController());
  }
}
