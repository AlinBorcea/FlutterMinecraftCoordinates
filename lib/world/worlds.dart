import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/app_widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/database/firestore_helper.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'add_edit.dart';

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
            return _worldsBody(context, snapshot);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AddEdit(null)));
        },
      ),
    );
  }

  Widget _worldsBody(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError)
      return errorIcon();
    else if (snapshot.connectionState == ConnectionState.waiting)
      return loadingIcon();
    else if (!snapshot.hasData)
      return noDataIcon();
    else
      return _worldsList(context, snapshot);
  }

  Widget _worldsList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: snapshot.data.documents.map((DocumentSnapshot document) {
        return _worldListTile(context, World.fromDocument(document));
      }).toList(),
    );
  }

  Widget _worldListTile(BuildContext context, World world) {
    return Dismissible(
      key: ObjectKey(world),
      background: Container(
        color: Colors.red,
      ),
      child: GestureDetector(
        onTap: () {
          debugPrint('worlds.dart -> pressed on listview item');
        },
        child: Card(
          margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            leading: Icon(Icons.work),
            title: Text(
              world.name,
              textScaleFactor: 1.5,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart)
          _showDeleteWorldDialog(context, world);
        else if (direction == DismissDirection.startToEnd)
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => AddEdit(world)));
      },
    );
  }

  Future<Widget> _showDeleteWorldDialog(BuildContext context, World world) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Are you sure you want to delete world ${world.name}?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              deleteWorld(world.name);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
