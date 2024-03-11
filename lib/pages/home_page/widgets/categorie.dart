import 'dart:convert';
import 'dart:math';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/home_page/models/categorie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class CategorySection extends StatelessWidget {
  String token = GetStorage().read('token').toString();

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(categorieUrl),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  final List<Color> categoryColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
     future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No categories available');
        } else {
           return Container(
            height: 270.0, 
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Category category = snapshot.data![index];
                final randomColor =
                    categoryColors[Random().nextInt(categoryColors.length)];

                return CategoryCard(
                  category: category,
                  //color: randomColor,
                  cardHeight: 10,
                  cardWidth: 10,
                );
              },
            ),
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final double cardHeight;
  final double cardWidth;

  CategoryCard({
    required this.category,
    required this.cardHeight,
    required this.cardWidth,
  });

  void navigateToCategoryDetails() {
    Get.toNamed('/add');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToCategoryDetails,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48.0, 
              height: 48.0,
              child: Image.network(
                "$baseUrl${category.images}",
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              category.libelle.length > 11
                  ? "${category.libelle.substring(0, 11)}..."
                  : category.libelle,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.0),
            Text(
              category.nombres,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
