import 'package:easy_market_client/pages/product_page/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}