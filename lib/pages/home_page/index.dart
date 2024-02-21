import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:easy_market_client/pages/home_page/widgets/categorie.dart';
import 'package:easy_market_client/pages/home_page/widgets/populaire.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  HomeController controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          'assets/logos/eranou_ligth.jpeg',
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
                      onChanged: (value) {
                       // controller.filterItems();
                      },
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
            SizedBox(height: 10.0),
            Container(
              height: 150,
              width: double.infinity,
              child: PageView(
                controller: _pageController,
                children: [
                  buildCarouselItem(Colors.blue, 'test1'.tr),
                  buildCarouselItem(Colors.green, 'test2'.tr),
                  buildCarouselItem(Colors.orange, 'test3'.tr),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            CategorySection(),
            SizedBox(height: 16.0),
            PopularSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget buildCarouselItem(Color color, String text) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            IconButton(
              icon: Icon(
                Icons.shop_2_sharp,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
