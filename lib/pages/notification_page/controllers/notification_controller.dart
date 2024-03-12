import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/notification_page/models/commande_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  List<Commande> commandeList = [];
  String id = GetStorage().read('id').toString();
  String token = GetStorage().read('token').toString();

  Future<List<Commande>> getAllCommande() async {
    String url = commandeUrl + id;
    try {
      final request = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (request.statusCode == 200 || request.statusCode == 201) {
        List<dynamic> commandes = jsonDecode(request.body)['commandesNonValides'];
        if (commandes.isNotEmpty) {
          for (var command in commandes) {
            String articleId = command['articleId'];
            Article articleDetails = await getArticleDetails(articleId);

            Commande commande = Commande(
              id: command['_id'],
              status: command['statut'],
              quantity: command['quantity'],
              article: articleDetails,
            );
            commandeList.add(commande);
          }
          update();
        }
        return commandeList;
      } else {
        throw Exception(
            'Erreur lors de la récupération des commandes : ${request.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors du chargement des commandes : $error');
    }
  }

  Future<Article> getArticleDetails(String articleId) async {
    String artUrl = articleUrl + articleId;
    final articleRequest = await http
        .get(Uri.parse(artUrl), headers: {'Authorization': 'Bearer $token'});

    if (articleRequest.statusCode == 200 || articleRequest.statusCode == 201) {
      Map<String, dynamic> articleData = jsonDecode(articleRequest.body);
      return Article(
        id: articleData['_id'],
        nom: articleData['nom'],
      );
    } else {
      throw Exception(
          'Erreur lors de la récupération des détails de l\'article : ${articleRequest.statusCode}');
    }
  }
}
