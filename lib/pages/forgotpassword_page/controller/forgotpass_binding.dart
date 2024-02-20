import 'package:easy_market_client/pages/forgotpassword_page/controller/forgotpass_controller.dart';
import 'package:get/get.dart';

class ForgotPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassController>(() => ForgotPassController());
  }
}
