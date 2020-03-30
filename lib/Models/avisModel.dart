class AvisModel {
  int id;
  String commentaire;
  String nomUtilisateur;
  String age;
  String lieuResidence;
  String sexe;
  String markerId;
  String date;
  List<dynamic> images;
  AvisModel(this.id, this.commentaire, this.nomUtilisateur, this.age,
      this.lieuResidence, this.sexe, this.markerId, this.date, this.images);

  factory AvisModel.fromJson(Map<String, dynamic> json) {
    return AvisModel(
      json['id'] as int,
      json['commentaire'] as String,
      json['nom_utilisateur'] as String,
      json['age'] as String,
      json['lieu_residence'] as String,
      json['sexe'] as String,
      json['marker_id'] as String,
      json['created_at'] as String,
      json['images'] as List<dynamic>,
    );
  }

  @override
  String toString() {
    return '{ id : ${this.id}, commentaire: "${commentaire}",nomUtilisateur: "${nomUtilisateur}", age: "${age}",lieuResidence:  "${lieuResidence}" , sexe: "${sexe}", markerId: "$markerId", created_at: "$date", images: "{${images.toString()}"}';
  }
}
