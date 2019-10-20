import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/world/worlds.dart';

void main() {
  runApp(MaterialApp(
    title: 'MC Coordinates',
    theme: ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Color.fromARGB(255, 243, 243, 243), // chill white
    ),
    home: Worlds(),
  ));
}
