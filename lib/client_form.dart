import 'package:shalomV1/model/clients.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shalomV1/model/manageData.dart';

void main() => runApp(new FormClient());

class FormClient extends StatefulWidget {
  @override
  FormClientFull createState() => FormClientFull();
}

class FormClientFull extends State<FormClient> {
  Clients client = new Clients();
  FormClientFull({Key key, this.client});
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List data;

  bool _value2 = false;
  String url = 'grivelerie.json';
  Directory dir;
  File jsonFile;
  bool fileExists = false;
  Map<String, String> fileContent;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  initState() {
    // dir = new Directory("data");
    //final path = _localPath;
    // print(path);
  }
  /*Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }*/

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
    client = new Clients();
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'Immatriculation'),
          maxLength: 32,
          validator: validationIM,
          onSaved: (String val) {
            client.immatriculation = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Modèle voiture'),
          maxLength: 32,
          // validator: validationIM,
          onSaved: (String val) {
            client.model = val;
          },
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Montant'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            maxLength: 5,
            //validator: validateMontant,
            onSaved: (val) {

              client.montant = double.parse(val)+0.0;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Nom'),
            maxLength: 32,
            validator: validateName,
            onSaved: (String val) {
              client.name = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Adresse'),
            keyboardType: TextInputType.text,
            maxLength: 50,
            validator: validateAdresse,
            onSaved: (String val) {
              client.adress = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Notes'),
            keyboardType: TextInputType.multiline,
            //validator: validateAdresse,
            onSaved: (String val) {
              client.note = val;
            }),
        new CheckboxListTile(
          value: _value2,
          onChanged: _value2Changed,
          title: new Text('Signaler comme suspect',
              style: TextStyle(color: Colors.red)),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.red,
        ),
        new SizedBox(
          height: 15.0,
          width: 50.0,
        ),
        new RaisedButton(
          onPressed: _sendToServer,
          child: Text('Enregistrer', style: TextStyle(color:Colors.white)),
          color:Color.fromRGBO(58, 66, 86, 1.0),
        )
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

/*String validateMontant(String value){
   String patttern = r'(^[0-9 ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Immatriculation is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Immatriculation must be a-z and A-Z";
    }
    return null;
}*/
  String validateAdresse(String value) {
    if (value.isEmpty) {
      return "Adress is Required";
    } 
    return null;
  }

  _sendToServer() {


    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      print('Form is not valid!  Please review and correct.');
      showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                      width: 130.0,
                      height: 120.0,
                      child: Text("Form is not valid!  Please review and correct. Veuillez contacter votre administrateur!")),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
            });
    } else {
      client.isSuspect = _value2;
      client.status = false;
      form.save(); //This invokes each onSaved event

      print('Form save called, newClient is created...');
      print('immatriculation: ${client.immatriculation}');
      print('model: ${client.model}');
      print('name: ${client.name}');
      print('montant: ${client.montant}');
      print('note: ${client.note}');
      print('adress: ${client.adress}');
      print('isSuspect: ${client.isSuspect}');
      print('status: ${client.status}');
      print('========================================');
      print('Submitting to back end...');

      ManageData.db
          .insertClient(client)
          .then((value) => {
            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('A new grivelerie is created with IM : ' +
                            client.immatriculation +
                            ' is created!'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                            },
                          ),
                        ]
                      );
                    })
            });
      
    }

    /* void createFile(Map<String, Clients> content, Directory dir, String fileName) {
    print("Creating file!");
    print(dir.path);
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(String key, Clients value) {
    print("Writing to file!");
    Map<String, Clients> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, Clients> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, url);
    }
    this.setState(() => fileContent = jsonDecode(jsonFile.readAsStringSync()));
    print(fileContent);
  }*/
  }
}
