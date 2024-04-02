import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/pages/home_page/widgets/my_circle_bottom_navigation.dart';
import 'package:easy_market_client/pages/profil_page/controllers/profil_controller.dart';
import 'package:easy_market_client/pages/profil_page/widgets/edite_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends GetWidget<ProfilController> {
  HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final nom = GetStorage().read('nom');
    final prenom = GetStorage().read('prenom');
    final phone = GetStorage().read('phone');
    final email = GetStorage().read('email');
    String address = GetStorage().read('addresse').toString() ?? "Cotonou";

      final imageUrl = "assets/logos/profil.jpeg";

    return Scaffold(
      appBar: AppBar(
        title: Text('profil'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(
                          imageUrl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'lname_fname'.tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '$nom $prenom',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'phone_number'.tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '$phone',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '$email',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(EditePage());
                },
                child: Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  Text(
                                    'address'.tr,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.place,
                                    weight: 12,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: Text(
                                "${address}",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ]),
                    )),
              ),

              /* SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.toNamed('/setting');
              },
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'setting'.tr,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(
                            Icons.chevron_right,
                            weight: 12,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ), */
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyCircleBottomNavigation(
        itemIcons: _controller.itemIcons,
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
}
