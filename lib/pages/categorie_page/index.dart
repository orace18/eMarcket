import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_market_client/pages/articles_page/index.dart';
import 'package:easy_market_client/pages/categorie_page/controllers/categorie_controller.dart';
import 'package:easy_market_client/pages/home_page/widgets/my_circle_bottom_navigation.dart';

class CategoriePage extends StatelessWidget {
  HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("category".tr),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: GetX<CategoriesController>(
              builder: (controller) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2.0,
                  ),
                  itemCount: controller.filteredCategories.length,
                  itemBuilder: (context, index) {
                    var category = controller.filteredCategories[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          category.libelle,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(category.nombres),
                        onTap: () {
                          Get.to(() => ArticlePage(
                              categorieLibelle: category.libelle));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
