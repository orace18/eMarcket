import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:easy_market_client/pages/home_page/widgets/categorie.dart';
import 'package:easy_market_client/pages/home_page/widgets/populaire.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          'assets/logos/easy_market.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        leadingWidth: double.infinity,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'seach'.tr,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(
                      Icons.wallet,
                      color: AppTheme.easyMarketMaterial,
                    ),
                    onPressed: () {
                      Get.toNamed('/wallet');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: AppTheme.easyMarketMaterial,
                    ),
                    onPressed: () {
                      Get.toNamed('/profil');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.0),
            CategorySection(),
            SizedBox(height: 16.0),
            PopularSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
