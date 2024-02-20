import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/home_page/models/categorie.dart';
import 'package:easy_market_client/pages/home_page/models/produit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  void navigateBack() => Get.back();
  bool isLoading = false;

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(popularProductUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(popularProductUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
