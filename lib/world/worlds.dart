import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/app_widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'add.dart';

class Worlds extends StatefulWidget {
  @override
  State createState() => _WorldsState();
}

class _WorldsState extends State<Worlds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worlds'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              debugPrint('lib/world/worlds.dart -> account pressed!');
            },
          ),
        ],
        ),
      body: Center(
        child: StreamBuilder(
          stream: Firestore.instance.collection('Worlds').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return _worldsBody(snapshot);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => Add()));
        },
      ),
    );
  }
}

Widget _worldsBody(AsyncSnapshot<QuerySnapshot> snapshot) {
  if (snapshot.hasError)
    return errorIcon();
  else if (snapshot.connectionState == ConnectionState.waiting)
    return loadingIcon();
  else if (!snapshot.hasData)
    return noDataIcon();
  else
    return _worldsList(snapshot);
}

Widget _worldsList(AsyncSnapshot<QuerySnapshot> snapshot) {
  return ListView(
    children: snapshot.data.documents.map((DocumentSnapshot document) {
      return _worldListTile(World.fromDocument(document));
    }).toList(),
  );
}

Widget _worldListTile(World world) {
  return GestureDetector(
    onTap: () {
      debugPrint("Worlds.dart -> Pressed on world ${world.name}");
    },
    child: Card(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(Icons.work),
        title: Text(world.name, textScaleFactor: 1.5,),
      ),
    ),
  );
}
