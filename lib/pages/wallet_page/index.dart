import 'package:easy_market_client/pages/wallet_page/widgets/send_money.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatelessWidget {
  final balance = GetStorage().read('balance') ?? 0;
  @override
  Widget build(BuildContext context) {
    final format = NumberFormat("#,##0 FCFA");
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Portefeuille'),
      ),
      body: Column(
        children: [
          Container(
            // height: 150,
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.transparent,
              color: AppTheme.easyMarketMaterialAccent,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/logos/portefeuille.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      'solde'.tr + ': ${format.format(balance)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                  Get.toNamed('/paiement');
                },
                child: Text(
                  'recharge'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  Get.toNamed('/transaction');
                },
                child: Text(
                  'tr_history'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0),
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
              Get.to(SendMoneyPage());
            },
            child: Text(
              'recharge'.tr + ' ' + 'other_user'.tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
