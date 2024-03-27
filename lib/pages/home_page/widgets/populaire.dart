import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/articles_page/index.dart';
import 'package:easy_market_client/pages/home_page/controllers/home_controller.dart';
import 'package:easy_market_client/pages/home_page/models/produit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularSection extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('populaire'.tr,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Container(
          height: 230.0,
          margin: EdgeInsets.only(bottom: 16.0),
          child: FutureBuilder<List<Article>>(
            future: controller.fetchArticles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No popular items available');
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                            ArticlePage(categorieLibelle: article.categorie));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0),
                        height: 200.0,
                        width: 150.0,
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "$baseUrl${article.photo}",
                                  height: 90,
                                  width: 90,
                                ),
                                Text(
                                  article.nom,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                  child: Text(
                                    article.description.length > 20
                                        ? "${article.description.substring(0, 20)}..."
                                        : article.description,
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${article.prixPromo != null ? "${article.prixPromo} FCFA" : "Prix non disponible"}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
