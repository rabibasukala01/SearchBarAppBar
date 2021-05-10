import 'package:flutter/material.dart';

void main() {
  runApp(Myapplication());
}

class Myapplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Bar "),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchData());
            },
          ),
        ],
      ),
    );
  }
}

class SearchData extends SearchDelegate<String> {
  final names = ["rabi", "Basukala", "haha", "lol", "hya", "etc", "rrr"];

  final namehistory = ["haha", "lol", "hya", "etc"];

  @override
  List<Widget> buildActions(BuildContext context) {
    //acction in appbar (clear)
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // for showing result based on selection from tala HERE showing container after tapping/selecting the suggestionlist
    return Container(
      width: 12.0,
      height: 120.0,
      color: Colors.amber,
      child: Text(query), //query==already told tala herta
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when typing
    final suggestionList = query
            .isEmpty //query==methods ho which is typed by users then become searchresult after selection
        ? namehistory
        : names.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        //  leading:Icon(Icons.place) ,
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),y
              
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(
                      color: Colors.grey[850],
                    ))
              ]),
        ),
      ),
      itemCount: query.length,
    );
  }
}
