import 'package:easy_market_client/pages/settings_page/controllers/setting_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  final SettingContoller controller = Get.put(SettingContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Language:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  onPressed: () => controller.changeAppLanguage(Locale('en')),
                  child: Text('English', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      ),),
                ),
                SizedBox(width: 16),
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
                  onPressed: () => controller.changeAppLanguage(Locale('fr')),
                  child: Text('Français', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      ),),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Current Language: ${controller.language}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

