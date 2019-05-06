import 'package:flutter/material.dart';
import 'package:shalomV1/detail_client.dart';
import 'package:shalomV1/admin.dart';
import 'package:shalomV1/About.dart';
import 'package:shalomV1/model/clients.dart';
import 'package:shalomV1/client_form.dart';
import 'package:shalomV1/model/manageData.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
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
  static Future<List<Clients>> clients;
  static List<Clients> dataClients= new List();
  static List<Clients> searchResult=new List();
  static bool _isSearching=false;
  static String _searchText = "";

  Icon searchIcon = new Icon(Icons.search);
  static TextField textField = new TextField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.search), hintText: "Rechercher..."),
    onChanged: (String searchText) {
      if(searchResult!=null)searchResult.clear();
      print(dataClients.length);
      _searchText = searchText;
      for (int i = 0; i < dataClients.length; i++) {
        Clients data = dataClients[i];
        if (data.immatriculation
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchResult.add(data);
        }
      }
      _isSearching=true;
      if(searchText==null) _isSearching=false;
      print(searchResult.length);
    },
  );
  @override
  void initState() {
    clients = ManageData.db.getClients();
    dataClients =new List();
    clients.then((value) => {
      value.isNotEmpty?value.forEach((f)=>{dataClients.add(f)}) : print("Warning: Null value of client")
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Clients client) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.perm_identity, color: Colors.white),
          ),
          title: Text(
            client.immatriculation == null
                ? 'XX XXX XX'
                : client.immatriculation,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      // tag: 'hero',
                      child: Text(
                    client.montant == null
                        ? 'XX €'
                        : client.montant.toString() + "€",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ))),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(client.model == null ? 'XXXXXXX' : client.model,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailClient(client: client)));
          },
        );

    Card makeCard(Clients client) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: client.isSuspect ? BoxDecoration(color: Color.fromRGBO(100, 75, 96, .9)):BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(client),
          ),
        );

    final makeBody = FutureBuilder<List<Clients>>(
        // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        future: clients,
        builder: (BuildContext context, AsyncSnapshot<List<Clients>> snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Clients item = snapshot.data[index];
                  if (item.immatriculation
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()))
                    return makeCard(item);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    final resultBody = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:searchResult==null?0: searchResult.length,
        itemBuilder: (BuildContext context, int index) {
            Clients item;
          if(searchResult!=null)
            item= searchResult[index];
          else 
            item=dataClients[index];

          if (item.immatriculation
              .toLowerCase()
              .contains(_searchText.toLowerCase())) return makeCard(item);
        });

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton( // refesh page
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
               setState(() {
                clients =ManageData.db.getClients(); 
                clients.then((value) => {
                  value.isNotEmpty?value.forEach((f)=>{dataClients.add(f)}) : print("Warning: Null value of client")
                });
               });
              },
            ),
            IconButton( // add new grivelerie
              icon: Icon(Icons.person_add, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormClient()));
              },
            ),
            IconButton( // manage data
              icon: Icon(Icons.block, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Admin()));
              },
            ),
            IconButton(
              icon: Icon(Icons.build, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => About()));
              },
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: textField,
      actions: <Widget>[
        IconButton(
          icon: searchIcon,
          onPressed: () {
            setState(() {
              if (this.searchIcon.icon != Icons.search) {
                this.searchIcon = new Icon(
                  Icons.close,
                  color: Colors.white,
                );
              } else {
                this.searchIcon = new Icon(
                  Icons.search,
                  color: Colors.white,
                );
              }
            });
          },
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: _isSearching?resultBody:makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}
