import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_market_client/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceChoosePage extends StatefulWidget {
  @override
  _PlaceChoosePageState createState() => _PlaceChoosePageState();
}

class _PlaceChoosePageState extends State<PlaceChoosePage> {
  TextEditingController _locationController = TextEditingController();
  final montant = GetStorage().read('montant');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('livraison_place'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Lieu de livraison',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onSubmitted: (value) {
                          _searchLocation();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchLocation();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Montant: $montant FCFA'),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppTheme.easyMarketMaterial,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  String total = GetStorage().read("montant").toString();
                  Get.dialog(
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
                            buyProducts(_locationController.text.toString());
                            Get.offAllNamed('/home');
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'valid'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buyProducts(String livraisonPlace) async {
    final balance = GetStorage().read('balance');

    if (montant == null || livraisonPlace.isEmpty) {
      returnError('Montant ou lieu de livraison non spécifié');
      return;
    }

    String dateTime = DateTime.now().toString();
    String id = GetStorage().read('id').toString();
    String nom = GetStorage().read('nom').toString() +
        " " +
        GetStorage().read('prenom').toString();
    String idCommande = dateTime + id + nom;

    if (montant > balance) {
      returnError('short_sold'.tr);
    } else {
      //final montantTotal = balance - montant;
      print("L'id de la commande: $idCommande");
      print("Le nom: $nom");
      print("Le montant: $montant");
      print("L'id du user: $id");
      print("Le lieu: $livraisonPlace");
      try {
        final request = await http.post(Uri.parse(payProductUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'userId': id,
              'delivery_place': livraisonPlace,
              'IdCommande': idCommande,
              'total_price': montant,
            }));
        if (request.statusCode == 200 || request.statusCode == 201) {
          final response = jsonDecode(request.body);
          GetStorage().write('balance', response['balance']);
          returnSuccess(response['message']);
        } else {
          final response = jsonDecode(request.body);
          returnError(response['message']);
        }
      } catch (error) {
        throw Exception('Erreur: $error');
      }
    }
  }

  Future<List<String>> getLocationSuggestions(String query) async {
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

  void showLocationSuggestions(List<String> suggestions, BuildContext context,
      TextEditingController textEditingController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    textEditingController.text = suggestions[index];
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _searchLocation() async {
    String query = _locationController.text;
    if (query.isNotEmpty) {
      List<String> suggestions = await getLocationSuggestions(query);
      showLocationSuggestions(suggestions, context, _locationController);
    }
  }
}
