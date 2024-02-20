import 'package:easy_market_client/pages/settings_page/controllers/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingContoller>(() => SettingContoller());
  }
}
