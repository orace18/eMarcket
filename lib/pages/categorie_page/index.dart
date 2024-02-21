/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_market_client/pages/articles_page/index.dart';
import 'package:easy_market_client/pages/categorie_page/controllers/categorie_controller.dart';
import 'package:easy_market_client/pages/categorie_page/models/categorie.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';

class CategoriePage extends GetWidget<CategoriesController> {
  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.amber,
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("category".tr),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                RxList<Categorie> categories = <Categorie>[].obs;
                if (value.isEmpty) {
                  categories.refresh();
                } else {
                  var filteredCategories = categories
                      .where((category) => category.libelle
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  categories.assignAll(filteredCategories);
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Categorie>>(
              future: controller.fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erreur : ${snapshot.error}");
                } else {
                  List<Categorie> categories = snapshot.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 2.0,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: cardColors[index % cardColors.length],
                        child: ListTile(
                          title: Text(categories[index].libelle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          subtitle: Text(categories[index].nombres, style: TextStyle(color: Colors.white),),
                          onTap: () {
                            Get.to(() => ArticlePage(
                                categorieLibelle: categories[index].libelle));
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_market_client/pages/articles_page/index.dart';
import 'package:easy_market_client/pages/categorie_page/controllers/categorie_controller.dart';
import 'package:easy_market_client/pages/categorie_page/models/categorie.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';

class CategoriePage extends GetWidget<CategoriesController> {
  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.amber,
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("category".tr),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder()
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  controller.filteredCategories.assignAll(controller.categories);
                } else {
                  var filteredCategories = controller.categories
                      .where((category) =>
                          category.libelle.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                  controller.filteredCategories.assignAll(filteredCategories);
                }
              },
            ),
          ),
          Expanded(
            child: Obx(() => GridView.builder(
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
                  color: cardColors[index % cardColors.length],
                  child: ListTile(
                    title: Text(category.libelle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text(category.nombres, style: TextStyle(color: Colors.white),),
                    onTap: () {
                      Get.to(() => ArticlePage(
                          categorieLibelle: category.libelle));
                    },
                  ),
                );
              },
            )),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
