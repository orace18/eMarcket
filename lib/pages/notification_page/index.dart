import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
      ),
      body: Center(
        child: Text('Contenu des notifications'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
