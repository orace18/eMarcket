import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/categorie_page/models/categorie.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class CategoriesController extends GetxController {
  RxList<Categorie> categories = <Categorie>[].obs;
  RxList<Categorie> filteredCategories = <Categorie>[].obs;
  String token = GetStorage().read('token').toString();

  void navigateBack() => Get.back();

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Appel à la fonction pour charger les catégories au démarrage du contrôleur
  }

  /*  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse("$categorieUrl"));

      if (response.statusCode == 200) {
        Iterable categoriesJson = json.decode(response.body);
        categories.assignAll(categoriesJson.map((category) => Categorie(
          id: category['_id'],
          libelle: category['libelle'],
          description: category['description'],
          nombres: "category['nombres']", 
        )).toList());
        filteredCategories.assignAll(categories); 
      } else {
        throw Exception("Échec de chargement des catégories");
      }
    } catch (error) {
      print("Erreur lors du chargement des catégories : $error");
    }
  } */

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(countCategoriUrl),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> categoriesJson = json.decode(response.body)['result'];
        categories.assignAll(categoriesJson
            .map((categoryData) => Categorie(
                  id: null,
                  libelle: categoryData['categoryName'],
                  nombres: categoryData['articleCount'].toString(),
                ))
            .toList());
        filteredCategories.assignAll(categories);
      } else {
        throw Exception("Échec de chargement des catégories");
      }
    } catch (error) {
      print("Erreur lors du chargement des catégories : $error");
    }
  }
}
