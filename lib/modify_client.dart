import 'package:shalomV1/model/clients.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shalomV1/model/manageData.dart';

void main() => runApp(new ModFormClient());

class ModFormClient extends StatefulWidget {

   final Clients client;
  ModFormClient({Key key, this.client}): super(key: key);
  
  @override
  ModFormClientFull createState() => ModFormClientFull();
}

class ModFormClientFull extends State<ModFormClient> {
 
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List data;

  bool _valueSuspect = false;
  bool _valueStatus = false;
  String url = 'grivelerie.json';
  Directory dir;
  File jsonFile;
  bool fileExists = false;
  Map<String, String> fileContent;
  Clients clientGet;
  int _groupValue =0;
  int _groupValue1 =0; 
  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
//  void _value2Changed(bool value) => setState(() =>{ _value2 = value});
  //void _value1Changed(bool value) => setState(() =>{ _value3 = value});

  
  /*Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Modifier les informations'),
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
  void _valueChange(int value) {
    setState(() {
       _groupValue = value;
       
      switch (value) {
        case 0:
          _valueSuspect = true;
          break;
        case 1:
          _valueSuspect = false;
          break;
      }
    }) ;
  }
  void _valueChange1(int value) {
    setState(() {
       _groupValue1 = value;
       
      switch (_groupValue1) {
        case 0:
          _valueStatus = false;
          break;
        case 1:
          _valueStatus = true;
          break;
      }
    }) ;
  }
  
  Widget formUI() {
    clientGet = widget.client;
    return Column(
      children: <Widget>[
        
        TextFormField(
          decoration: InputDecoration(hintText: 'Immatriculation'),
          maxLength: 32,
          initialValue: clientGet.immatriculation,
          validator: validationIM,
          onSaved: (String val) {
            clientGet.immatriculation = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Modèle voiture'),
          initialValue: clientGet.model,
          maxLength: 32,
          // validator: validationIM,
          onSaved: (String val) {
            clientGet.model = val;
          },
        ),

        new TextFormField(
            decoration: new InputDecoration(hintText: 'Nom'),
            maxLength: 32,
            initialValue: clientGet.name,
            validator: validateName,
            onSaved: (String val) {
              clientGet.name = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Adresse'),
            initialValue: clientGet.adress,
            keyboardType: TextInputType.text,
            maxLength: 50,
            validator: validateAdresse,
            onSaved: (String val) {
              clientGet.adress = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Notes'),
            initialValue: clientGet.note ,
            keyboardType: TextInputType.multiline,
            //validator: validateAdresse,
            onSaved: (String val) {
              clientGet.note = val;
            }),
            new Container(
              padding: EdgeInsets.all(8.0),
              child: new  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: _valueChange,
                  ),
                  new Text('Suspect'),
                  new Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: _valueChange,
                  ),
                   new Text('Non Suspect'),
                ]
              ),
            ),
         new Divider(),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Montant N°1'),
            keyboardType: TextInputType.number,
            initialValue: clientGet.montant.toString(),
            maxLength: 5,
            //validator: validateMontant,
            onSaved: (val) {
              clientGet.montant = double.parse(val);
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Montant  N°1 '),
            keyboardType: TextInputType.number,
            initialValue: clientGet.othermontant1.toString(),
            maxLength: 5,
            //validator: validateMontant,
            onSaved: (val) {
              clientGet.othermontant1 = double.parse(val);
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Montant N°2'),
            keyboardType: TextInputType.number,
            initialValue: clientGet.othermontant2.toString(),
            maxLength: 5,
            //validator: validateMontant,
            onSaved: (val) {
              clientGet.othermontant2 = double.parse(val);
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Montant  N°3'),
            keyboardType: TextInputType.number,
            initialValue: clientGet.othermontant3.toString(),
            maxLength: 5,
            //validator: validateMontant,
            onSaved: (val) {
              clientGet.othermontant3 = double.parse(val);
            }),
        
        new Divider(),
        
        new Row(
          children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(4.0)),
                child: Text(
                  clientGet.montant.toString() == null
                      ? 'XXXXX'
                      : "Total : " + (clientGet.montant + 
                                        clientGet.othermontant1+
                                          clientGet.othermontant2 +
                                            clientGet.othermontant3 ).toString() + "\€",
                  style: TextStyle(color: Colors.red),
                )
              ),
              
              new Radio(
                value: 0,
                groupValue: _groupValue1,
                onChanged: _valueChange1,
              ),
              new Text('Non Réglée'),
              new Radio(
                value: 1,
                groupValue: _groupValue1,
                onChanged: _valueChange1,
              ),
              new Text('Réglée'),
                    
                    ]
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
      clientGet.isSuspect = _valueSuspect;
      clientGet.status = _valueStatus;
      form.save(); //This invokes each onSaved event

      print('Form save called, newClient is created...');
      print('immatriculation: ${clientGet.immatriculation}');
      print('model: ${clientGet.model}');
      print('name: ${clientGet.name}');
      print('montant: ${clientGet.montant}');
      print('note: ${clientGet.note}');
      print('adress: ${clientGet.adress}');
      print('isSuspect: ${clientGet.isSuspect}');
      print('status: ${clientGet.status}');
      print('========================================');
      print('Submitting to back end...');

      ManageData.db
          .updateClient(clientGet)
          .then((value) => {
            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Update have been made on ' +
                            clientGet.immatriculation +
                            ' Client!'),
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
