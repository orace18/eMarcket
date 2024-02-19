import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_market_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceChoosePage extends StatefulWidget {
  @override
  _PlaceChoosePageState createState() => _PlaceChoosePageState();
}

class _PlaceChoosePageState extends State<PlaceChoosePage> {
  TextEditingController _locationController = TextEditingController();
  String montant = GetStorage().read('montant').toString();

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
                onPressed: () {
                  
                },
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
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
