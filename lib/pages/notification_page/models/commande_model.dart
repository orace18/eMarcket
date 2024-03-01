class Article {
  final String id;
  final String nom;

  Article({
    required this.id,
    required this.nom,
  });
}
class Commande {
  final String id;
  final String status;
  final int quantity;
  Article article;

  Commande({
    required this.id,
    required this.quantity,
    required this.status,
    required this.article,
  });

/* factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      articleId: json['articleId'] ?? '',
    );
  }*/
}