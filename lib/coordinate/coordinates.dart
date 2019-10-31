import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/models/coordinate.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'package:minecraft_coordinates/app_widgets/listview_body.dart';

class Coordinates extends StatefulWidget {
  final World _world;

  Coordinates(this._world);

  @override
  State createState() => CoordinatesState();
}

class CoordinatesState extends State<Coordinates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget._world.name}'),),
      body: StreamBuilder(
        stream: Firestore.instance.collection(widget._world.name).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return listViewBody(context, snapshot, false);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint('pressed on Fab add coordinate');
        },
      ),
    );
  }
}
