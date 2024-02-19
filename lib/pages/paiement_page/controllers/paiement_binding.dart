import 'package:easy_market_client/pages/paiement_page/controllers/paiement_controller.dart';
import 'package:get/get.dart';

class PaiementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaiementController>(() => PaiementController());
  }
}
