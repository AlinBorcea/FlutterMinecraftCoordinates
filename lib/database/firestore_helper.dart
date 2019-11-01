import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'package:minecraft_coordinates/models/coordinate.dart';

/// World related functions. add, update and delete documents in Firestore
Future<void> addWorld(World world) async {
  Firestore.instance
      .collection('Worlds')
      .document(world.name)
      .setData(world.toMap());
}

Future<void> updateWorld(String oldName, World world) async {
  if (oldName == world.name) {
    Firestore.instance
        .collection('Worlds')
        .document(oldName)
        .updateData(world.toMap());
  } else {
    deleteWorld(oldName);
    addWorld(world);
  }
}

Future<void> deleteWorld(String name) async {
  Firestore.instance.collection('Worlds').document(name).delete();
}

/// Coordinate related functions. add, update and delete documents in Firestore
Future<void> addCoordinate(String colName, Coordinate coordinate) async {
  Firestore.instance
      .collection(colName)
      .document(coordinate.name)
      .setData(coordinate.toMap());
}

Future<void> updateCoordinate(String colName, String oldName, Coordinate coordinate) async {
  if (oldName == coordinate.name)
    Firestore.instance.collection(colName).document(oldName).updateData(coordinate.toMap());
  else {
    deleteCoordinate(colName, oldName);
    addCoordinate(colName, coordinate);
  }
}

Future<void> deleteCoordinate(String colName, String docName) async {
  Firestore.instance.collection(colName).document(docName).delete();
}
