import 'package:flutter/material.dart';
import 'package:beautiful_list/detail_client.dart';
import 'package:beautiful_list/model/clients.dart';
import 'package:beautiful_list/client_form.dart';

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
  static List clients;
  static List searchResult;
  static final TextEditingController _controller = new TextEditingController();
  static bool _isSearching;
  static String _searchText = "";

  Icon searchIcon = new Icon(Icons.search);
  static TextField textField = new TextField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        prefixIcon: Icon(Icons.search), hintText: "Rechercher..."),
    onChanged: (String searchText) {
      searchResult.clear();

      for (int i = 0; i < clients.length; i++) {
        Clients data = clients[i];
        if (data.immatriculation
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchResult.add(data);
        }
      }
    },
  );
  @override
  void initState() {
    clients = getClients();
    searchResult = getClients();
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
            client.immatriculation,
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
                    client.montant.toString() + "€",
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
                    child: Text(client.name,
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
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(client),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: searchResult.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(searchResult[index]);
        },
      ),
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person_add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormClient()));
              },
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
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
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

List getClients() {
  return [
    Clients(
      immatriculation: "CP 405 RT",
      name: "Patrick Tchepga",
      adress: "23 Rue Jean Jaurès, 90000 Belfort",
      montant: 20,
      model: "C4 Citroen",
      note: "Mes différentes remarques",
      isSuspect: true,
    ),
    Clients(
      immatriculation: "AS 782 AZ",
      name: "Marcial Perien",
      adress: " 4 avenue Leclerc, 90000 Belfort",
      montant: 70,
      model: "Mustande",
      note: " Refaire mes premiers test",
      isSuspect: false,
    ),
    Clients(
      immatriculation: "PT 120 BR",
      name: "Pauline Nicoles",
      adress: "14 Rue des Anges, 90200 Valdoie",
      montant: 20,
      model: "Peugeot 200",
      note: "Mes premières remarques",
      isSuspect: false,
    ),
    Clients(
      immatriculation: "CP 405 RT",
      name: "Patricia Nganang",
      adress: "56 boulevard de Prague , 90000 Belfort",
      montant: 20,
      note: "je fais plusieurs remarques sur ce véhicules",
      model: "Peugeot 206",
      isSuspect: true,
    ),
    Clients(
      immatriculation: "KJ 412 ER",
      name: "Ribertte Hilard",
      adress: " 23 Rue Jean Jaurès, 90000 Belfort",
      montant: 20,
      model: " C4 Citroen",
      note: " je fais un test pour voir si tout fonctionne",
      isSuspect: false,
    ),
    Clients(
      immatriculation: "CX 205 PR",
      name: "Cedric Heintz",
      adress: "14 avenue Foche, 90000 Belfort",
      montant: 20,
      model: "Mercedès",
      note: "Rien à signaler",
      isSuspect: false,
    ),
  ];
}
