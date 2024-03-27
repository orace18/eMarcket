import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/pages/articles_page/models/article_models.dart';
import 'package:easy_market_client/pages/product_page/index.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ArticlePage extends StatefulWidget {
  final String categorieLibelle;

  ArticlePage({required this.categorieLibelle});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> allArticles = [];
  List<Article> filteredArticles = [];
  String token = GetStorage().read('token').toString();
  TextEditingController searchController = TextEditingController();

  Future<void> fetchArticles() async {
    final response = await http.get(
      Uri.parse(articleUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        allArticles = data.map((item) => Article.fromJson(item)).toList();
        filterArticles('');
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

  void filterArticles(String query) {
    setState(() {
      filteredArticles = allArticles
          .where((article) =>
      article.categorie == widget.categorieLibelle &&
          article.nom.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.categorieLibelle}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                filterArticles(query);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rechercher',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    filterArticles('');
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        "$baseUrl${filteredArticles[index].photo}",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(filteredArticles[index].nom),
                        SizedBox(
                          height: 10,
                        ),
                        Text(filteredArticles[index].quantity.toString()),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${filteredArticles[index].prixPromo} FCFA"),
                            const SizedBox(width: 1.5),
                            Expanded(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.green,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                      "${filteredArticles[index].prix} FCFA",
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
                      color: Colors.grey,
                      onPressed: () {
                        showProductDetails(filteredArticles[index]);
                      },
                    ),
                    onTap: () {
                      showProductDetails(filteredArticles[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
