
import 'package:flutter/material.dart';

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
                onPressed: () {},
                child:
                    const Text('export data', style: TextStyle(fontSize: 20)),
              ),
              Spacer(
                flex: 1,
              ),
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () {},
                child:
                    const Text('import data', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ],
      ),
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Center(
              child: Row(children: <Widget>[
            Text(
              '@author: ptchepga - dev' + version,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
            Text("Tous droits réversés - Shalom Total"),
          ]))),
    );
    final topAppBar = new AppBar(
      title: new Text(' A-propos'),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      //appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}
