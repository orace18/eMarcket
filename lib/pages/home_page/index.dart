import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:easy_market_client/pages/home_page/widgets/categorie.dart';
import 'package:easy_market_client/pages/home_page/widgets/populaire.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';


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
                         controller.filterItems(value);
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
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16.0),
              child: CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return buildCarouselItem(
                    Colors.blue, 
                    'test${index + 1}'.tr,
                  );
                },
                options: CarouselOptions(
                  height: 190.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
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
