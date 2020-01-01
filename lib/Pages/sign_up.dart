import 'package:flutter/material.dart';
import 'package:patrimoine_app/theme.dart';
import '../UI/elements.dart';

class SignUpFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.Green,
        body: Stack(children: <Widget>[
          Center(
              child: Image.asset(
            'assets/images/name.png',
          )),
          Container(
            margin: EdgeInsets.all(00),
            padding: EdgeInsets.only(top: 80),
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/background.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: ButtonIdentifier(),
          ),
        ]));
  }
}

class SignUpSecondPage extends StatefulWidget {
  @override
  _SignUpSecondPageState createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.Green,
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 80),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/background.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFieldNomUtilisateur(),
                  TextFieldAge(),
                  TextFieldLieuDeResidence(),
                  SizedBox(
                    height: 20,
                  ),
                  RadioButton(),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonIdentifier2(),
                ],
              ),
            )
          ],
        ));
  }
}
