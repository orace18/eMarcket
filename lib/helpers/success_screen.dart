import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
   var amount;
   var transactionId;

  SuccessScreen({required this.amount, required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Pay'),
      ),
      body: Center(
        child: Text('Le montant: $amount et l\'id de la transaction est $transactionId'),
        
      ),
    );
  }
}
