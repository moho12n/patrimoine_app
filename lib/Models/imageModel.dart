class ImageModel {
  int idAvis;
  String image;

  ImageModel(this.image, this.idAvis);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      json['image'] as String,
      json['avis_id'] as int,
    );
  }

  @override
  String toString() {
    return '{ idAvis : ${this.idAvis}, image: $image}';
  }
}
