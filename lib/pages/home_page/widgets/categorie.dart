import 'dart:convert';
import 'dart:math';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/home_page/models/categorie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class CategorySection extends StatelessWidget {
  
  Future<List<Category>> fetchCategories() async {

    String token = GetStorage().read('token').toString();
    final response = await http.get(Uri.parse(categorieUrl),
      headers: {'Authorization': 'Bearer $token'}
    );

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'category'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!.map((category) {
                    final randomColor =
                        categoryColors[Random().nextInt(categoryColors.length)];

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryCard(
                        category: category,
                        color: randomColor,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final Color color;

  CategoryCard({
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.category,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed('/add');
              },
              title:Center( 
               child: Text(
                category.libelle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0, 
                ),
              )),
              subtitle: Center(
                child: Text(
                category.nombres,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
