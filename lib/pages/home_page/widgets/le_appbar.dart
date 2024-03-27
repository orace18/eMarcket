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
                child: Image.network(
                  'https://imgs.search.brave.com/aARZMd7Xs_hsb5ParXMmNoz8QRGLX4Ui8ROWYuZ5QjE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni83NzEvNzcxNTEz/LnBuZw', // Remplacez par le chemin de votre image
                  height: 30,
                  width: 30,
                 
                ),
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
            Get.toNamed('/profil');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
              'https://th.bing.com/th/id/OIP.audMX4ZGbvT2_GJTx2c4GgHaHw?w=197&h=206&c=7&r=0&o=5&pid=1.7', // Remplacez par le chemin de votre image
              //color: Color(0xFF196CB0),
                scale: 8.0
            ),
            ),
          ),
        ),
      ],
    );
  }
}
