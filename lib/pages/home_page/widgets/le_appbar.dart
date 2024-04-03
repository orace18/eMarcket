import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar() : preferredSize = Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Container(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed('/wallet');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logos/portefeuille.png',
                  height: 30,
                  width: 30,
                 
                ),
                /* CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(
               /*  'assets/logos/wallet.png',
            ),
            ), */ */
              ),
            ),
          ],
        ),
      ),
      title: Image.asset(
        'assets/logos/eranou.png',
       // fit: BoxFit.cover,
        height: 150,
        width: double.infinity,
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/setting');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(
                'assets/logos/reglages.png',
            ),
            ),
          ),
        ),
      ],
    );
  }
}
