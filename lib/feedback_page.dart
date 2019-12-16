import 'package:flutter/material.dart';

class FeedbackPage extends MaterialPageRoute<Null> {
  FeedbackPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Feedback Page"),
              elevation: 1.0,
            ),
          );
        });
}
