class FeedbackModel {
  String commentaire;
  String nomUtilisateur;
  String age;
  String lieuResidence;
  String sexe;
  String markerId;

  String rating;
  FeedbackModel(
    this.commentaire,
    this.nomUtilisateur,
    this.age,
    this.lieuResidence,
    this.sexe,
    this.rating,
    this.markerId,
  );

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      json['commentaire'] as String,
      json['nom_utilisateur'] as String,
      json['age'] as String,
      json['lieu_residence'] as String,
      json['sexe'] as String,
      json['marker_id'] as String,
      json['rating'] as String,
    );
  }

  @override
  String toString() {
    return '{ "commentaire": "${commentaire}","nom_utilisateur": "${nomUtilisateur}", "age": "${age}","lieu_residence":  "${lieuResidence}" , sexe: "${sexe}", "marker_id": "$markerId", "rating": "$rating", "marker_id": "{${markerId}"}';
  }
}
