import 'package:shalomV1/model/clients.dart';
import 'package:flutter/material.dart';
import 'package:shalomV1/model/manageData.dart';

class DetailClient extends StatelessWidget {
  final Clients client;

  DetailClient({Key key, this.client}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textModel = Text(
      client.model == null ? 'XXXX' : client.model,
      style: TextStyle(color: Colors.white, fontSize: 10.0),
    );
    final montantClient = Container(
      padding: const EdgeInsets.all(7.0),
      margin: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        "Montant facture : " + client.montant.toString() == null
            ? 'XXXXX'
            : client.montant.toString() + "\€",
        style: TextStyle(color: Colors.red),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100.0),
        Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 40.0,
        ),
        Text(
          client.isSuspect || client.isSuspect == null
              ? "Signalé comme suspect"
              : "Rien à signaler",
          style: TextStyle(
              color: client.isSuspect ? Colors.red : Colors.white,
              fontSize: 20.0),
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          client.immatriculation == null ? 'XX XXX XX' : client.immatriculation,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: textModel),
            /*Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      client.immatriculation,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: montantClient)*/
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
    final adressText = Text(
      client.adress == null ? 'XXXX' : client.adress,
      style: TextStyle(fontSize: 18.0),
    );
    final nameClient = Text(
      client.name == null ? 'XXXX' : client.name,
      style: TextStyle(fontSize: 20.0),
    );
    final noteContent = Container(
      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Remarque : ",
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              client.note == null ? 'XXXX' : client.note,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
    final deleteButton = Container(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        width: MediaQuery.of(context).size.width-160,
        child: RaisedButton(
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Delete confirmation",
                          style: TextStyle(fontSize: 21.0, color: Colors.red),
                        ),
                        content: Container(
                          width: 130.0,
                          height: 120.0,
                          child:Center(
                            child:Column(
                              children: <Widget>[
                                 Text('Enter password to confirm that "' +client.immatriculation +'" will be delete.'),
                                 TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(
                                      ),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  maxLength: 32,
                                  onSaved: (String val) {
                                    passwordConfirm = val;
                                  },
                                ),
                              ]
                            )
                          )
                        ),  
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: new Text("Accept"),
                            onPressed: () {
                              
                              ManageData.db.deleteClient(client.immatriculation);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    })
              },
          color: Color.fromRGBO(0, 66, 0, 0.5),
          child: Text("Supprimer ce compte",
              style: TextStyle(color: Colors.white)),
        ));

    final modidyButton = Container(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        width: MediaQuery.of(context).size.width-160,
        child: RaisedButton(
          onPressed: () => {
               
              },
          color: Color.fromRGBO(0, 66, 0, 0.5),
          child: Text("modifier ce compte",
              style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Expanded(
      child: Center(
        child: Column(
          children: <Widget>[
            nameClient,
            adressText,
            montantClient,
            noteContent,
            modidyButton,
            deleteButton
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
