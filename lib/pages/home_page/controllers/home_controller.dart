/*import 'dart:convert';
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

  Future<void> fetchItems() async {
    try {
      final categoriesResponse = await http.get(Uri.parse("$categorieUrl"));
      if (categoriesResponse.statusCode == 200) {
        Iterable categoriesJson = json.decode(categoriesResponse.body);
        categories.assignAll(categoriesJson.map((category) => Categorie(
          id: category['_id'],
          libelle: category['libelle'],
          description: category['description'],
          nombres: category['nombres'],
        )));
        filteredCategories.assignAll(categories);
      } else {
        throw Exception("Échec de chargement des catégories");
      }
    } catch (error) {
      throw Exception("Échec de chargement des catégories: $error");
    }

    try {
      final productsResponse = await http.get(Uri.parse("$productUrl"));
      if (productsResponse.statusCode == 200) {
        Iterable productsJson = json.decode(productsResponse.body);
        products.assignAll(productsJson.map((product) => Article(
          id: product['_id'],
          nom: product['nom'],
          description: product['description'],
          photo: product['photo'],
          // Ajoutez d'autres champs si nécessaire
        )));
        filteredProducts.assignAll(products);
      } else {
        throw Exception("Échec de chargement des produits");
      }
    } catch (error) {
      throw Exception("Échec de chargement des produits: $error");
    }
  }

}
 */

import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/home_page/models/categorie.dart';
import 'package:easy_market_client/pages/home_page/models/produit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  bool isLoading = false;

  RxList<Category> categories = <Category>[].obs;
  RxList<Article> products = <Article>[].obs;
  RxList<Category> filteredCategories = <Category>[].obs;
  RxList<Article> filteredProducts = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  void navigateBack() => Get.back();

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
    final response = await http.get(Uri.parse(categorieUrl)); // Assurez-vous d'utiliser la bonne URL

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchItems() async {
    try {
      final categoriesResponse = await http.get(Uri.parse(categorieUrl));
      if (categoriesResponse.statusCode == 200) {
        Iterable categoriesJson = json.decode(categoriesResponse.body);
        categories.assignAll(categoriesJson.map((category) => Category(
          id: category['_id'],
          libelle: category['libelle'],
          description: category['description'],
          nombres: category['nombres'],
        )));
        filteredCategories.assignAll(categories);
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (error) {
      throw Exception("Failed to load categories: $error");
    }

    try {
      final productsResponse = await http.get(Uri.parse(articleUrl));
      if (productsResponse.statusCode == 200) {
        Iterable productsJson = json.decode(productsResponse.body);
        products.assignAll(productsJson.map((product) => Article(
          id: product['_id'],
          nom: product['nom'],
          description: product['description'],
          photo: product['photo'],
          prixPromo: product['prix_promo'],
          categorie: product['categorie'],
          idMarchand: product['merchandId'],
        )));
        filteredProducts.assignAll(products);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (error) {
      throw Exception("Failed to load products: $error");
    }
  }
}
