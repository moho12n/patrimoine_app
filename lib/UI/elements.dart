import 'package:flutter/material.dart';
import 'package:patrimoine_app/theme.dart';
import '../Pages/sign_up.dart';
import '../Pages/map_main.dart';
import '../main.dart';
//***************************************Buttons */
class ButtonIdentifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: ThemeColors.shadow, blurRadius: 12, offset: Offset(0, 12))
        ],
      ),
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpSecondPage()),
            );
          },
          child: Text(
            "S'identifier",
            style: TextStyle(
                color: ThemeColors.blueMain,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          )),
    );
  }
}

class ButtonIdentifier2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 286,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: ThemeColors.shadow, blurRadius: 12, offset: Offset(0, 12))
        ],
      ),
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          child: Text(
            "S'identifier",
            style: TextStyle(
                color: ThemeColors.blueMain,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          )),
    );
  }
}

class RadioButton extends StatefulWidget {
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String gender;
  int _radioValue1 = -1;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      SizedBox(
        width: 25,
      ),
      Radio(
        activeColor: Colors.white,
        value: 0,
        groupValue: _radioValue1,
        onChanged: _handleRadioValueChange1,
      ),
      Text(
        'Homme',
        style: TextStyle(fontSize: 14.0, color: Colors.white),
      ),
      SizedBox(
        width: 40,
      ),
      Radio(
        activeColor: Colors.white,
        value: 1,
        groupValue: _radioValue1,
        onChanged: _handleRadioValueChange1,
      ),
      Text(
        'Femme',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
    ]);
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          gender = "Femme";
          break;
        case 1:
          gender = "homme";
          break;
      }
    });
  }
}

/********************* Text Fields */
class TextFieldNomUtilisateur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        labelStyle: TextStyle(color: Colors.white70),
        icon: Icon(
          Icons.person,
          color: Colors.white70,
        ),
        labelText: "Nom d'utilisateur",
      ),
    );
  }
}

class TextFieldAge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        labelStyle: TextStyle(color: Colors.white70),
        icon: Icon(
          Icons.perm_contact_calendar,
          color: Colors.white70,
        ),
        labelText: "Age",
      ),
    );
  }
}

class TextFieldLieuDeResidence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        labelStyle: TextStyle(color: Colors.white70),
        icon: Icon(
          Icons.home,
          color: Colors.white70,
        ),
        labelText: "Lieu de résidence",
      ),
    );
  }
}
