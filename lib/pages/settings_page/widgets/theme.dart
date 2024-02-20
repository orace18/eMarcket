import 'package:easy_market_client/pages/settings_page/controllers/setting_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePage extends StatelessWidget {
  final SettingContoller controller = Get.put(SettingContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Theme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'light'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: controller.isLightMode.value,
                  onChanged: (value) => controller.changeThemeMode(),
                ),
                Text(
                  'dark'.tr,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppTheme.easyMarketMaterial,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
              onPressed: () => controller.changeThemeMode(),
              child: Text('change_theme'.tr, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      ),),
            ),
          ],
        ),
      ),
    );
  }
}
