import 'package:cloud_firestore/cloud_firestore.dart';

class World {
  String _name;
  String _img;

  World(this._name, this._img);

  String get name => _name;

  String get img => _img;
}

World toWorld(DocumentSnapshot document) {
  return new World(document['Name'], document['Img']);
}
