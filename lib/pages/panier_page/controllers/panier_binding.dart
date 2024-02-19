import 'package:easy_market_client/pages/panier_page/controllers/panier_controller.dart';
import 'package:get/get.dart';

class PanierBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PanierController>(() => PanierController());
  }
}