import 'package:cloud_firestore/cloud_firestore.dart';

class World {
  String _name;
  String _playStyle;
  String _seed;
  int _color;

  World(this._name, this._playStyle, this._seed, this._color);

  World.fromDocument(DocumentSnapshot document) {
    _name = document['Name'];
    _playStyle = document['PlayStyle'];
    _seed = document['Seed'];
    _color = document['Color'];
  }

  String get name => _name;

  String get playStyle => _playStyle;

  String get seed => _seed;

  int get color => _color;

  Map<String, dynamic> toMap() {
    return {
      'Name': _name,
      'PlayStyle': _playStyle,
      'Seed': _seed,
      'Color': _color,
    };
  }
}
