import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/panier_page/models/article_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TransactionPage extends StatelessWidget {
   String userId = GetStorage().read('id').toString();
  List<Transaction> transactions = <Transaction>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Transactions'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: chargerTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement de l\'historique des transactions'),
            );
          } else {
            return (transactions.isEmpty)
                ? Center(
                    child: Text("Aucune transaction disponible."),
                  )
                : buildTransactionList();
          }
        },
      ),
    );
  }

  Widget buildTransactionList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                color: Colors.blue[100],
                child: ListTile(
                  title: Text('ID de Transaction: ${transaction.transactionId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${transaction.date}'),
                      Text('Montant: \FCFA ${transaction.amount.toStringAsFixed(1)}'),
                      Text('Statut: ${transaction.status}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> chargerTransactions() async {
    final url = transactionHistoryUrl + userId;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        // Récupérer les informations des transactions
        transactions = jsonResponse.map((transactionData) {
          return Transaction(
            transactionData['id'],
            transactionData['date'],
            transactionData['amount'].toDouble(),
            transactionData['status'],
          );
        }).toList();

       // update();
      } else {
        throw Exception('Failed to load transaction history');
      }
    } catch (error) {
      print('Error loading transactions: $error');
    }
  }
}

class Transaction {
  final String transactionId;
  final String date;
  final double amount;
  final String status;

  Transaction(this.transactionId, this.date, this.amount, this.status);
}
