import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/categorie_page/models/categorie.dart';
import 'package:easy_market_client/pages/home_page/models/categorie.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  void navigateBack() => Get.back();

Future<List<Categorie>> fetchCategories() async {
  final response = await http.get(Uri.parse("$categorieUrl"));
  
  if (response.statusCode == 200) {
    Iterable categoriesJson = json.decode(response.body);
    return categoriesJson.map((category) => Categorie(
      id: category['_id'],
      libelle: category['libelle'],
      description: category['description'],
    )).toList();
  } else {
    throw Exception("Échec de chargement des catégories");
  }
}



}
