import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/app_widgets/components.dart';
import 'package:flutter/material.dart';

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

  );
}
