class Article {
  final String id;
  final String nom;
  final String categorie;
  late int prix;
  final int prixOriginal;
  final String image;
  int quantite;

  Article(this.id, this.nom, this.categorie, this.prix, this.prixOriginal, this.image,
      this.quantite);
}
