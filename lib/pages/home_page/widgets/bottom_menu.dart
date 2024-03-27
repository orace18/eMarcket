/*import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 10, 74, 126),
          currentIndex: selectedIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
              backgroundColor: Color.fromARGB(255, 10, 74, 126),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shape_line_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(),
              label: '',
            ),
             const BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: '',
            ), 
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '',
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });

            switch (index) {
              case 0:
                selectedIndex = 0;
                Get.offAllNamed('/home');
                break;
              case 1:
                selectedIndex = 1;
                Get.toNamed('/add');
                break;
              case 2:
                selectedIndex = 2;
                Get.toNamed('/cart');
                break;
               case 3:
              selectedIndex = 3;
                Get.toNamed('/notification');
                break; 
              case 4:
                selectedIndex = 4;
                Get.toNamed('/chat');
                break;
            }
          },
        ),
        Positioned(
          bottom: 15.0,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/cart');
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.amber,
                size: 30.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 0.0),
          child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 10, 74, 126),
          currentIndex: selectedIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
              backgroundColor: Color.fromARGB(255, 10, 74, 126),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shape_line_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: '',
            ),
/*
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '',
            ),
*/
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });

            switch (index) {
              case 0:
                selectedIndex = 0;
                Get.offAllNamed('/home');
                break;
              case 1:
                selectedIndex = 1;
                Get.toNamed('/add');
                break;
              case 2:
                selectedIndex = 2;
                Get.toNamed('/cart');
                break;
              case 3:
                selectedIndex = 3;
                Get.toNamed('/notification');
                break;/*
              case 4:
                selectedIndex = 4;
                Get.toNamed('/chat');
                break;*/
            }
          },
        ),),
        Positioned(
          bottom: 1.0,
          left: MediaQuery.of(context).size.width / 1.8,
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/cart');
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 10, 74, 126),
                size: 30.0,
              ),
            ),
          ),
        ),
        ],
    );
  }
}