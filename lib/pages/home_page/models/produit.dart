class Article {
  final String nom;
  final String description;
  final String photo;
  final int prixPromo;
  final String id;
  final String idMarchand;
  final String categorie;

  Article({
    required this.nom,
    required this.description,
    required this.photo,
    required this.prixPromo,
    required this.id,
    required this.idMarchand,
    required this.categorie,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      nom: json['nom'],
      description: json['description'],
      photo: json['photo'],
      prixPromo: json['promo_prix'],
      id: json['id'],
      idMarchand: json['merchant_id'],
      categorie: json['categorie'],
    );
  }
}
