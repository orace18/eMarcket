import 'package:easy_market_client/pages/panier_page/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../../helpers/constants.dart';

class MyCircleBottomNavigation extends StatelessWidget {
  final List<IconData> itemIcons;
  final String centerText;
  final int selectedIndex;
  final Function(int) onItemPressed;
  final double? height;
  final Color selectedColor;
  final Color selectedLightColor;
  final Color unselectedColor;

  const MyCircleBottomNavigation({
    Key? key,
    required this.itemIcons,
    required this.centerText,
    required this.selectedIndex,
    required this.onItemPressed,
    this.height,
    this.selectedColor = const Color(0xff46BDFA),
    this.unselectedColor = const Color(0xffB5C8E7),
    this.selectedLightColor = const Color(0xff77E2FE),
  })  : assert(itemIcons.length == 3, "Item must equal 3"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    final height = this.height ?? getRelativeHeight(0.076);

    return SizedBox(
      height: height + getRelativeHeight(0.025),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              color: Theme.of(context).cardColor,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getRelativeWidth(0.1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  itemIcons[0],
                                  color: selectedIndex == 0
                                      ? selectedColor
                                      : unselectedColor,
                                  size: getRelativeWidth(0.07),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(1);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  itemIcons[1],
                                  color: selectedIndex == 1
                                      ? selectedColor
                                      : unselectedColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(2);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  itemIcons[2],
                                  color: selectedIndex == 2
                                      ? selectedColor
                                      : unselectedColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    onItemPressed(1);
                    Get.to(MonPanierPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(60)),
                      color: Theme.of(context).cardColor,
                    ),
                    height: getRelativeWidth(0.18),
                    width: getRelativeWidth(0.18),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding / 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? primaryColor
                                : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: selectedIndex == 1
                                    ? Colors.blue
                                    : primaryColor,
                                width: 3),
                          ),
                          child: Center(
                            child: Icon(Icons.shopping_cart_sharp, color: Colors.blue, size: 20,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

double getRelativeHeight(double percentage) {
  return percentage * SizeConfig.screenHeight;
}

double getRelativeWidth(double percentage) {
  return percentage * SizeConfig.screenWidth;
}
