import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/pages/home_page/widgets/le_appbar.dart';
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
                  viewportFraction: 1.0, // Occupy the whole container
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration:
                      Duration(milliseconds: 800), // Set a very short duration
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
                Icons.shape_line_rounded,
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
