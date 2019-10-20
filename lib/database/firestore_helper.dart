import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_coordinates/models/world.dart';

/// World related functions. add, update and delete documents in Firestore
Future<void> addWorld(World world) async {
  Firestore.instance.collection('Worlds').document(world.name).setData(world.toMap());
}

Future<void> updateWorld(World world) async {
  Firestore.instance.collection('Worlds').document(world.name).updateData(world.toMap());
}

Future<void> deleteWorld(String name) async {
  Firestore.instance.collection('Worlds').document(name).delete();
}
