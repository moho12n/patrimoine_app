import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  String name;
  String age;
  String adress;
  String gender;
  User({this.name, this.age, this.adress, this.gender});

  User userFromJson(String str) {
    final jsonData = json.decode(str);
    return User.fromJson(jsonData);
  }

  String userToJson(User data) {
    final dyn = data.toJson();
//********final */
    return json.encode(dyn);
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        age: json["age"],
        adress: json["adress"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "adress": adress,
        "gender": gender,
      };
  @override
  String toString() {
    // TODO: implement toString
    return '{name : "$name", adress : "$adress, gender: $gender", age: $age}';
  }
}
