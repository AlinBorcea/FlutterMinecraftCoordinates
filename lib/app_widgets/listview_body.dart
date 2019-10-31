import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/models/coordinate.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'package:minecraft_coordinates/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/world/add_edit_world.dart';
import 'package:minecraft_coordinates/world/worlds.dart';
import 'package:minecraft_coordinates/app_widgets/stateless_widgets.dart';
import 'package:minecraft_coordinates/coordinate/coordinates.dart';

Widget listViewBody(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, bool isWorld) {
  if (snapshot.hasError)
    return errorIcon();
  else if (snapshot.connectionState == ConnectionState.waiting)
    return loadingIcon();
  else if (!snapshot.hasData)
    return noDataIcon();
  else
    return _list(context, snapshot, isWorld);
}

Widget _list(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, bool isWorld) {
  return ListView(
    children: snapshot.data.documents.map((DocumentSnapshot document) {
      return _listTile(
          context,
          isWorld
              ? World.fromDocument(document)
              : Coordinate.fromDocument(document),
          isWorld);
    }).toList(),
  );
}

Widget _listTile(BuildContext context, Object object, bool isWorld) {
  return Dismissible(
    key: ObjectKey(object),
    background: Container(
      color: Colors.red,
    ),
    child: GestureDetector(
      onTap: () {
        if (isWorld)
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => Coordinates(object)));
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
            _titleOf(object),
            textScaleFactor: 1.5,
          ),
        ),
      ),
    ),
    onDismissed: (direction) {
      if (direction == DismissDirection.endToStart)
        _showDeleteDialog(context, object);
      else if (direction == DismissDirection.startToEnd) {
        if (object is World)
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AddEditWorld(object)));
        //else if (object is Coordinate)
          //Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AddEditCoordinate(object)));
      }
    },
  );
}

Future<Widget> _showDeleteDialog(BuildContext context, Object object) {
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text('Are you sure you want to delete ${_titleOf(object)}?'),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => Worlds()));
          },
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            if (object is World) deleteWorld(object.name);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

String _titleOf(Object object) {
  if (object is World)
    return object.name;
  else if (object is Coordinate) return object.name;

  return 'LOLLOL';
}
