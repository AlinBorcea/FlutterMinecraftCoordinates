import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/app_widgets/listview_body.dart';
import 'add_edit_world.dart';

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
            return listViewBody(context, snapshot, true);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AddEditWorld(null)));
        },
      ),
    );
  }


}
