import "package:flutter/material.dart";
import "package:firebase_database/firebase_database.dart";
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:patrimoine_app/Models/User.dart';

class DatabaseClass extends StatefulWidget {
  @override
  _DatabaseClassState createState() => _DatabaseClassState();
}

class _DatabaseClassState extends State<DatabaseClass> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      databaseReference = database.reference().child("bdd");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: RaisedButton(
              onPressed: () {                
                User user = User(
                    name: "Mohamed", adress: "CITE", age: "26", gender: "df");
                    print(user.toJson());
                databaseReference = database.reference().child("bdd");
                databaseReference.push().set(user.toJson());
              },
              child: Text("press")),
        ));
  }
}
