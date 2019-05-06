import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new Admin());

class Admin extends StatefulWidget {
  @override
  AdminFull createState() => AdminFull();
}

class SessionAdmin {
  String oldpass='';
  String newpass='';
}

class AdminFull extends State<Admin> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String oldpass='';
  String newpass='';
  //AdminFull({Key key, this.user});
  @override
  initState() {
    // dir = new Directory("data");
    //final path = _localPath;
    // print(path);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Ajouter une nouvelle grivelerie'),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: true,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  _checkingCurrentPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savePass = prefs.getString('shalomPassword');
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      print('Form is not valid!  Please review and correct.');
    } else {
      form.save();
     if (savePass == null || savePass.isEmpty)
        await prefs.setString('shalomPassword', "password");
      if (savePass == oldpass) {
        await prefs.setString('shalomPassword', newpass);
        print('password :  $savePass .');
        print(newpass);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                      width: 130.0,
                      height: 120.0,
                      child: Text("votre mot de passe a été modifié")));
          });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                      width: 130.0,
                      height: 120.0,
                      child: Text("Ancien mot de passe incorrecte")));
            });
      }
    }
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Text(' Changer le mot de passe administrateur'),
        TextFormField(
          decoration: InputDecoration(hintText: 'Ancien mot de passe'),
          maxLength: 32,
          //validator: validationIM,
          onSaved: (String val) {
            oldpass = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Nouveau mot de passe:'),
          maxLength: 32,
          // validator: validationIM,
          onSaved: (String val) {
            newpass = val;
          },
        ),
        RaisedButton(
            color: Color.fromRGBO(0, 66, 0, 0.5),
            child: Text("valider", style: TextStyle(color: Colors.white)),
            onPressed: _checkingCurrentPassword)
      ],
    );
  }

  validationIM(String value) async {
    String patttern = r'(^[a-zA-Z0-9 ]*$)';
    //RegExp regExp = new RegExp(patttern);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String oldPassword = prefs.getString('password');
    print('oldp: $oldPassword .');

    //await prefs.setInt('counter', counter);
    if (value != oldPassword) {
      return "Worn password!";
    }
    return null;
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "A name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "A name must be a-z and A-Z";
    }
    return null;
  }

  _sendToServer() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      print('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

    }
  }
}
