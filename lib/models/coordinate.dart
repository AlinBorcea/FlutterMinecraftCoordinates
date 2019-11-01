import 'package:cloud_firestore/cloud_firestore.dart';

class Coordinate {
  String _name;
  String _x;
  String _y;
  String _z;
  int _color;

  Coordinate(this._name, this._x, this._y, this._z, this._color);

  Coordinate.fromDocument(DocumentSnapshot document) {
    _name = document['Name'];
    _x = document['X'];
    _y = document['Y'];
    _z = document['Z'];
    _color = document['Color'];
  }

  String get name => _name;

  String get x => _x;

  String get y => _y;

  String get z => _z;

  int get color => _color;

  Map<String, dynamic> toMap() {
    return {
      'Name': _name,
      'X': _x,
      'Y': _y,
      'Z': _z,
      'Color': _color,
    };
  }

}