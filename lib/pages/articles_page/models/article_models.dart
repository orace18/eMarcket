class Article {
  final String id;
  final String nom;
  final double prix;
  final double prixPromo;
  final String description;
  final String categorie;
  final String photo;
  final String merchantId;
  final int quantity;

  Article({
    required this.id,
    required this.nom,
    required this.prix,
    required this.prixPromo,
    required this.description,
    required this.categorie,
    required this.photo,
    required this.merchantId,
    required this.quantity,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['_id'] ?? '',
      nom: json['nom'] ?? '',
      prix: (json['prix'] ?? 0).toDouble(),
      prixPromo: (json['promo_prix'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      categorie: json['categorie'] ?? '',
      photo: json['photo'] ?? '',
      merchantId: json['merchant_id'] ?? '',
      quantity: (json['quantity'] ?? 0).toInt(),
    );
  }
}
