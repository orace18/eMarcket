import 'package:easy_market_client/pages/wallet_page/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
  }
  
}