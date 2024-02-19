import 'package:easy_market_client/pages/notification_page/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}