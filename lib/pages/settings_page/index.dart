import 'package:easy_market_client/api/auth/api_auth_client.dart';
import 'package:easy_market_client/pages/settings_page/widgets/langue.dart';
import 'package:easy_market_client/pages/settings_page/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                title: Text('change_lang'.tr),
                trailing: Icon(Icons.language),
                onTap: () {
                  Get.to(LanguagePage());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('change_theme'.tr),
                trailing: Icon(Icons.color_lens),
                onTap: () {
                  Get.to(ThemePage());
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('log_out'.tr),
                trailing: Icon(Icons.exit_to_app),
                onTap: () async {
                  bool isValid = await AuthClient().logout();
                  if (isValid == true) {
                    Get.offAllNamed("/login");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
