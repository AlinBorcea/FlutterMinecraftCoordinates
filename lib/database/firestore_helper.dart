import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/models/world.dart';

/// World related functions. add, update and delete documents in Firestore
Future<void> addWorld(World world) async {
  Firestore.instance.collection('Worlds').document(world.name).setData(world.toMap());
}

Future<void> updateWorld(String oldName, World world) async {
  if (oldName == world.name) {
    Firestore.instance.collection('Worlds').document(oldName).updateData(world.toMap());

  } else {
    deleteWorld(oldName);
    addWorld(world);
  }
}

Future<void> deleteWorld(String name) async {
  Firestore.instance.collection('Worlds').document(name).delete();
}
