/* import 'package:easy_market_client/constants.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:easy_market_client/pages/panier_page/controllers/panier_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MonPanierPage extends StatelessWidget {
  final PanierController panierController = PanierController();

/*   setState() {
    panierController.chargerArticles();
  } */

  @override
  Widget build(BuildContext context) {
    panierController.chargerArticles();
    return Scaffold(
      appBar: AppBar(
        title: Text('my_cart'.tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
           // physics: const NeverScrollableScrollPhysics(),
            itemCount: panierController.articles.length,
            itemBuilder: (context, index) {
              final article = panierController.articles[index];
              return Card(
                color: Colors.green[100],
                child: ListTile(
                  leading: Image.network(article.image),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(article.nom),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${article.categorie}'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.red,
                            onPressed: () {
                              panierController.diminuerQuantite(article);
                            },
                          ),
                          Obx(() =>
                          Text(
                            '${article.quantite}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.green,
                            onPressed: () {
                              panierController.augmenterQuantite(article);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\FCFA ${(article.prix * article.quantite).toStringAsFixed(3)}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '-\FCFA ${(article.prixOriginal * article.quantite).toStringAsFixed(1)}',
                        style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('sous_total'.tr),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Text('\FCFA ${panierController.sousTotal}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('taxe'.tr + ' (2%)'),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Text('-\FCFA ${panierController.taxe}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total'.tr),
                SizedBox(
                  width: 130,
                ),
                Expanded(
                  child: Text(
                    '\FCFA ${panierController.total}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
             // GetStorage().write('montant', panierController.total);
              panierController.passerAuPaiement();
            },
            child: Text(
              'pay'.tr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
 */

import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:easy_market_client/pages/panier_page/controllers/panier_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonPanierPage extends StatelessWidget {
  final PanierController panierController = PanierController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_cart'.tr),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: panierController.chargerArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement du panier'),
            );
          } else {
            return (panierController.articles.isEmpty)
                ? Center(
                    child: Text("Vous n'avez rien dans votre panier."),
                  )
                : buildCartList();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget buildCartList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int index = 0; index < panierController.articles.length; index++)
            buildCartItem(index),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('sous_total'.tr),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Text('\FCFA ${panierController.sousTotal}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('taxe'.tr + ' (18%)'),
                SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: Text('+\ FCFA ${panierController.taxe}'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total'.tr),
                SizedBox(
                  width: 130,
                ),
                Expanded(
                  child: Text(
                    '\FCFA ${panierController.total}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
              // GetStorage().write('montant', panierController.total);
              panierController.passerAuPaiement();
            },
            child: Text(
              'pay'.tr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(int index) {
    final article = panierController.articles[index];
    return
     Card(
      color: Colors.green[100],
      child: ListTile(
        leading: Image.network(
          article.image,
          height: 50,
          width: 50,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(article.nom, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${article.categorie}'),
            Row(
              children: [
                Text(
                  'quantity'.tr + ' ${article.quantite}',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\FCFA ${(article.prixOriginal * article.quantite).toStringAsFixed(1)}',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '-\FCFA ${(article.prix * article.quantite).toStringAsFixed(1)}',
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  } 
}
