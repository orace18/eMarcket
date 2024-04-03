import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/helpers/constants.dart';
import 'package:easy_market_client/pages/panier_page/models/cart_item_model.dart';
import 'package:easy_market_client/pages/panier_page/widgets/place_choose.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_market_client/pages/panier_page/models/article_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanierController extends GetxController {
  List<CartItem> cartItems = [];
  List<Article> articles = <Article>[].obs;
  final idText = GetStorage().read('id');
  String token = GetStorage().read('token').toString();

/*   Future<void> chargerArticles() async {
    final url = myCartUrl + id;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Récupérer les informations des articles
        articles = (jsonResponse['articlesInfo'] as List<dynamic>)
            .map((articleInfo) {
              final articleInfoData = articleInfo['articleInfo'];
              return Article(
                articleInfoData['nom'],
                articleInfoData['categorie'],
                articleInfoData['prix'].toDouble(),
                articleInfoData['prix'].toDouble(),
                baseUrl + articleInfoData['photo'],
                articleInfo['quantity'],
              );
            })
            .toList();

        update();
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (error) {
      print('Error loading articles: $error');
    }
  }
 */

  Future<void>supprimerArticle(String articleId)async{
    String id  = GetStorage().read('id').toString();
    try{
      final body = jsonEncode({
        'userId': id,
        'articleId': articleId
      });
      final request = await http.post(Uri.parse(removetoCartUrl),
      headers: {"Content-Type":"application/json",
      'Authorization': 'Bearer $token'
      },
      body:  body
      );

      if(request.statusCode == 200 || request.statusCode == 201){
        final response = json.decode(request.body);
        returnSuccess(response['message']);
      }else{
        final response = json.decode(request.body);
        returnError(response['message']);
      }
    }catch(error){
      throw Exception('Erreur lors de la suppression $error');
    }
  }

  bool isLoading = false;

  Future<void> chargerArticles() async {
    isLoading = true;
    update();
    String id = idText.toString();
    final url = myCartUrl + id;
    try {
      final response = await http.get(Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        articles =
            (jsonResponse['articlesInfo'] as List<dynamic>).map((articleInfo) {
          final articleInfoData = articleInfo['articleInfo'];
          return Article(
            articleInfoData['id'],
            articleInfoData['nom'],
            articleInfoData['categorie'],
            articleInfoData['prix'],
            articleInfoData['promo_prix'],
            baseUrl + articleInfoData['photo'],
            articleInfo['quantity'],
          );
        }).toList();

        isLoading = false;
        update();
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (error) {
      isLoading = false;
      update();
      print('Error loading articles: $error');
    }
  }

  var promos = [].obs;

  double get sousTotal {
    double somme = 0;
    for (var article in articles) {
      somme += article.prix * article.quantite;
    }
    return double.parse((somme).toStringAsFixed(1));
  }

  double get taxe {
    return double.parse((sousTotal * 0.18).toStringAsFixed(1));
  }

  double get total {
    return double.parse((sousTotal + 0).toStringAsFixed(1));
  }

  void augmenterQuantite(Article article) {
    article.quantite++;

    Get.snackbar('Quantité augmentée',
        'La quantité de ${article.nom} a été augmentée à ${article.quantite}');
  }

  void diminuerQuantite(Article article) {
    if (article.quantite > 1) {
      article.quantite--;
      //articles.refresh();
      Get.snackbar('Quantité diminuée',
          'La quantité de ${article.nom} a été diminuée à ${article.quantite}');
    }
  }

  void passerAuPaiement() {
     GetStorage().write('montant', total);
     Get.to(PlaceChoosePage());
     
    /* Get.dialog(
      AlertDialog(
        title: Text('pay'.tr),
        content: Text('Voulez-vous payer ${total} FCFA ?'),
        actions: [
          TextButton(
            child: Text('exit'.tr),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text('pay'.tr),
            onPressed: () {
             
            },
          ),
        ],
      ), */
    
  }

  Future<List<String>> getPlaces(String query) async {
    try {
      final baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';

      final response = await http
          .get(Uri.parse('$baseUrl?input=$query&key=$google_api_key'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        if (data['predictions'] != null) {
          List<dynamic> predictions = data['predictions'];

          return predictions.map<String>((prediction) {
            return prediction['description'] as String;
          }).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de la récupération des lieux : $error ');
      return [];
    }
  }

  
}
