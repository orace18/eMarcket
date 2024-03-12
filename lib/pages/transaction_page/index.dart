import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/transaction_page/models/tansaction_model.dart';

class TransactionPage extends StatelessWidget {
  final String userId = GetStorage().read('id').toString();
  List<Transaction> transactions = <Transaction>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Transactions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: chargerTransactions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erreur de chargement de l\'historique des transactions ${snapshot.error}',
                ),
              );
            } else {
              return (transactions.isEmpty)
                  ? Center(
                      child: Text("Aucune transaction disponible."),
                    )
                  : TransactionListWidget(transactions: transactions);
            }
          },
        ),
      ),
    );
  }

  Future<void> chargerTransactions() async {
    final url = transactionHistoryUrl + userId;
    String token = GetStorage().read('token').toString();
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final List<dynamic> commandes = jsonResponse['commandes'];
        transactions = commandes.map((transactionData) {
          return Transaction.fromJson(transactionData);
        }).toList();
      } else {
        throw Exception('Failed to load transaction history');
      }
    } catch (error) {
      print('Error loading transactions: $error');
      throw Exception('Error loading transactions: $error');
    }
  }
}

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionListWidget({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - 20,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          Color cardColor = Color(0xFF061E31);
          if (transaction.type == 'recharge') {
            cardColor = Colors.green;
          } else {
            cardColor = Color(0xFF061E31);
          }
          DateTime dateTime = DateTime.parse(transaction.date);
          int heure = dateTime.hour;
          int minutes = dateTime.minute;
          int secondes = dateTime.second;
          String Lheure = "$heure:$minutes:$secondes";
          int mois = dateTime.month;
          int day = dateTime.day;
          int year = dateTime.year;
          String date = "$day/$mois/$year";

          return Card(
            color: cardColor,
            child: ListTile(
              title: Text('ID de Transaction: ${transaction.transactionId}',
                  style: TextStyle(color: Colors.white)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${date}' + " " + 'a'.tr + ' ' + '$Lheure',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('Montant: ${transaction.amount.toStringAsFixed(1)} FCFA',
                      style: TextStyle(color: Colors.white)),
                  Text('Statut: ${transaction.type}',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
