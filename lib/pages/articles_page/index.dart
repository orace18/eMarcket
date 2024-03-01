import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/articles_page/models/article_models.dart';
import 'package:easy_market_client/pages/product_page/index.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ArticlePage extends StatefulWidget {
  final String categorieLibelle;

  ArticlePage({required this.categorieLibelle});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> allArticles = [];

  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(articleUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        allArticles = data.map((item) => Article.fromJson(item)).toList();
      });
    } else {
      print('Erreur de chargement des articles: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  void showProductDetails(Article article) {
    Get.to(() => ProductPage(article: article));
  }

  List<Article> getArticlesByCategorie() {
    return allArticles
        .where((article) => article.categorie == widget.categorieLibelle)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Article> articles = getArticlesByCategorie();

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.categorieLibelle}"),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  "$baseUrl${articles[index].photo}",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(articles[index].nom),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${articles[index].prixPromo} FCFA"),
                      const SizedBox(width: 1.5),
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow
                              .ellipsis, // Ajoutez ceci pour gérer l'overflow
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.lineThrough,
                            ),
                            children: [
                              TextSpan(
                                text: "${articles[index].prix} FCFA",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: AppTheme.easyMarketMaterial,
                onPressed: () {
                  showProductDetails(articles[index]);
                },
              ),
              onTap: () {
                showProductDetails(articles[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
