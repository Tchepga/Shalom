import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shalomV1/model/clients.dart';
import 'package:shalomV1/model/manageData.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'main.dart';

void main() => runApp(new About());

class About extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(255, 255, 255, 1.0),
          fontFamily: 'Raleway'),
      home: new ListPage(title: 'Grivelerie - SHALOM'),
      // home: DetailClient(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Icon iconne = new Icon(Icons.backspace);
  String version = "beta0.5";

  @override
  initState() {
    //  dir = new Directory("data");
  }
  /*void createFile(Map<String, Clients> content, Directory dir, String fileName) {
    print("Creating file!");
    print(dir.path);
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }*/

  /*void writeToFile(String key, Clients value) {
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
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get _tempPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<String> get _localFile async {
    return await rootBundle.loadString('assets/Grivelerie.csv');
  }

  Future<File> get _createFile async {

   final path = await _localPath;
   print(path);
  return File('$path/Grivelerie.csv');
  }

  Future<File> get _dataToSend async {

   final path = await _tempPath;
   print(path);
  return File('$path/Grivelerie.csv');
  }

  Future<File> writeData(String data) async {
    
    final file = await _dataToSend;
    // Write the file
    return file.writeAsString('$data');
  }

  Future<void> sendEmail() async{
    
     final file = await _dataToSend;
    

    try {

      // Read the file
      String contents = await file.readAsString();
      print(contents);

      
  

     final attached =file.path;
    // getExternalStorageDirectory().then((v)=>print(v.list().first));
     //getApplicationDocumentsDirectory().then((value)=>print(value.absolute));
      final Email email = Email(
        body: 'Test extraction data grivelerie',
        subject: ' Data grivelerie',
        recipients: ['tchepgapatrick@yahoo.fr'],
        //cc: ['cc@example.com'],
        //bcc: ['bcc@example.com'],
         attachmentPath:     attached,
      );
    /* getApplicationDocumentsDirectory().then((v)=>{
       v.
     });*/
     await FlutterEmailSender.send(email);


      //return contents;
    } catch (e) {
      // If encountering an error, return 0
      print(e.toString());
      //return e.toString();
    }
  }
  
  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await _localFile;

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      print("reading problem");
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final makeBody = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*2*/
          Container(
              padding: const EdgeInsets.only(bottom: 8),
              margin: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: Text(
                  'Manage data',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
                ),
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.orange,
                onPressed: ()  {
                  //print(_localPath);
                  String dataTreat = "";
                  print("Operation Extraction de données de la base.");
                  ManageData.db.getClients().then((values) =>{
                    values.forEach((f) => {
                      //immatriculation-montant-note-model-status-name-adress-other1....
                      dataTreat += f.immatriculation +';'+ 
                        f.montant.toString()+';'+
                        f.note+';'+
                        f.model+';'+
                        f.status.toString()+';'+
                        f.name+';'+
                        f.isSuspect.toString()+';'+
                        f.adress+';'+
                        f.othermontant1.toString()+';'+
                        f.othermontant2.toString()+';'+
                        f.othermontant3.toString()+';'+'\n',
                       
                    }),
                   // print(dataTreat.substring(dataTreat.length - 40)),
                    writeData(dataTreat).then((f)=>{
                      print("Data have been extracted!"),
                      sendEmail()
                      
                      }),

                  });
                },
                child:
                    const Text('export data', style: TextStyle(fontSize: 20)),
              ),
              Spacer(
                flex: 1,
              ),
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () {
                  //String dataRaw="" ;
                  List<String> organizeData;
                  List<String> lineOfData;
                  Clients tempClient;
                  readData().then((value) => {
                        organizeData = value.split("\n"),
                        //print(organizeData),
                        organizeData.forEach((f) => {
                              if (f.isNotEmpty)
                                {
                                  lineOfData = f.split(";"),
                                  f = f.replaceAll(new RegExp(';;'), ';')
                                },
                              print(lineOfData),
                              lineOfData[1] =
                                  lineOfData[1].replaceAll(',', '.'),
                              lineOfData[1] = lineOfData[1].trimLeft(),

                              if (lineOfData[1].contains('+'))
                                print(
                                    " Data contains + characters! Wrong data"),
                              if (lineOfData[1].isEmpty)
                                lineOfData[1] = '0',

                              //print(lineOfData[1])
                              //print(lineOfData[1]),
                              //print(double.parse(lineOfData[1]))

                              tempClient = new Clients(
                                  adress: 'XXXX',
                                  immatriculation: lineOfData[0],
                                  isSuspect: false,
                                  model: lineOfData[3],
                                  montant: double.parse(lineOfData[1]),
                                  name: lineOfData[5],
                                  note: lineOfData[2],
                                  status: lineOfData[4].contains('1')),

                              ManageData.db
                                  .insertClient(tempClient)
                                  .then((f) => {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text(
                                                    "Import confirmation",
                                                    style: TextStyle(
                                                        fontSize: 21.0,
                                                        color: Colors.red),
                                                  ),
                                                  content: Text(
                                                      "All data have been imported from the csv file!"),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MyApp()));
                                                      },
                                                    ),
                                                  ]);
                                            })
                                      })
                                  .catchError((f) => {print(f)})
                            }),
                      });
                },
                child:
                    const Text('import data', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, bottom: 40),
              child: Text(
                "Cette application est une version d'essaie destiné à Total Access SHALOM  pour"
                " la gestion des grivéleries clients. Elle consiste au CRUD des clients concernés, à l'extraction et "
                "de l'importation des données clients. Une partie administration est aussi mis en place.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
          Center(
            child: RaisedButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: const Text('Revenir au menu principal',
                  style: TextStyle(fontSize: 20)),
            ),
          )
        ],
      ),
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Center(
              child: Column(children: <Widget>[
            Text(
              '@author: ptchepga - dev' + version,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
            Text("Tous droits réversés - Shalom Total"),
          ]))),
    );
    // final topAppBar = new AppBar(
    //   title: new Text(' A-propos'),
    //   backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    //   leading: InkWell(
    //     onTap: () {
    //       Navigator.of(context).pop();
    //     },
    //     child: Icon(Icons.arrow_back, color: Colors.white),
    //   ),
    // );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      //appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}
