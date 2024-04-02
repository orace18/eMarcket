import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/pages/home_page/widgets/le_appbar.dart';
import 'package:easy_market_client/pages/home_page/widgets/my_circle_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:easy_market_client/pages/home_page/widgets/categorie.dart';
import 'package:easy_market_client/pages/home_page/widgets/populaire.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageController = PageController(initialPage: 0);
  HomeController controller = HomeController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
             CarouselSlider.builder(
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
                  viewportFraction: 1.0, 
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration:
                      Duration(milliseconds: 800), 
                  autoPlayCurve: Curves.linear,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            SizedBox(height: 16.0),
            CategorySection(),
            SizedBox(height: 16.0),
            PopularSection(),
          ],
        ),
      ),
      bottomNavigationBar: MyCircleBottomNavigation(
        itemIcons: controller.itemIcons,
        centerText: 'Center',
        selectedIndex: 0,
        onItemPressed: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed('/home');
              break;
            case 1:
              Get.toNamed('/add');
              break;
            case 3:
              Get.toNamed('/notification');
              break;
            case 4:
              Get.toNamed('/profil');
              break;
          }
        },
      ),
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
                Icons.shape_line_rounded,
                color: Colors.blue,
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
