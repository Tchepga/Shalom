import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shalomV1/model/manageData.dart';

void main() => runApp(new Admin());

class Admin extends StatefulWidget {
  @override
  AdminFull createState() => AdminFull();
}
 class SessionAdmin {
   String name;
   String password;
 }
class AdminFull extends State<Admin> {
  
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  SessionAdmin user= new SessionAdmin();

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

  Widget formUI() {
    
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'user Admin'),
          maxLength: 32,
          validator: validationIM,
          onSaved: (String val) {
            user.name = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Password'),
          maxLength: 32,
          // validator: validationIM,
          onSaved: (String val) {
            user.password = val;
          },
        ),
      ],
    );
  }

  String validationIM(String value) {
    String patttern = r'(^[a-zA-Z0-9 ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Immatriculation is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Immatriculation must be a-z and A-Z";
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
