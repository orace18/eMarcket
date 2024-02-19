import 'package:easy_market_client/pages/categorie_page/controllers/categorie_controller.dart';
import 'package:get/get.dart';

class CategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}
