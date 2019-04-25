import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyMainScreen(),
      theme: ThemeData(primaryColor: Colors.red),
    );
  }
}


class MyMainScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return MyMainScreenState();
  }
}

class MyMainScreenState extends State<MyMainScreen>{

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Coding Club Events"),
      ),
      body: Container(
          child: 
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('events').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return new CustomCard(
                        document['title'],
                        document['description']
                      );
                    }).toList(),
                  );
              }
            },
          )
        )
      )
    ;
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String description;

  CustomCard(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(title),
              subtitle: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}
