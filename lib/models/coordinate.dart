import 'package:cloud_firestore/cloud_firestore.dart';

class Coordinate {
  String _name;
  String _x;
  String _y;
  String _z;

  Coordinate(this._name, this._x, this._y, this._z);

  Coordinate.fromDocument(DocumentSnapshot document) {
    _name = document['Name'];
    _x = document['X'];
    _y = document['Y'];
    _z = document['Z'];
  }

  String get name => _name;

  String get x => _x;

  String get y => _y;

  String get z => _z;

  Map<String, dynamic> toMap() {
    return {
      'Name': _name,
      'X': _x,
      'Y': _y,
      'Z': _z,
    };
  }

}