import 'package:easy_market_client/pages/product_page/index.dart';
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
                  
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('change_theme'.tr),
                trailing: Icon(Icons.color_lens),
                onTap: () {
                  // Action pour changer le thème
                  // (peut nécessiter la navigation vers une nouvelle page)
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('log_out'.tr),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  // Action pour la déconnexion
                  // (par exemple, retour à la page de connexion)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
