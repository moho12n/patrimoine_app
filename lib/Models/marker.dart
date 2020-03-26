class MarkersModel {
  int id;
  String name;
  String latitude;
  String longitude;
  String rating;
  String created_at;
  MarkersModel(
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.rating,
    this.created_at,
  );

  factory MarkersModel.fromJson(Map<String, dynamic> json) {
    return MarkersModel(
      json['id'] as int,
      json['name'] as String,
      json['latitude'] as String,
      json['longitude'] as String,
      json['rating'] as String,
      json['created_at'] as String,
    );
  }

  @override
  String toString() {
    return '{ id : ${this.id}, name: ${name},latitue: ${latitude}, longitude: ${longitude},rating:  ${rating} , created_at: ${created_at}}';
  }
}
