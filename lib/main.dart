import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/world/worlds.dart';

/// Got the colors from https://www.materialui.co/colors
// Color.fromARGB(255, 243, 243, 243), // chill white
// Color.fromARGB(255, 33, 33, 33), // rgba(97,97,97 ,1)
// Color.fromARGB(255, 55, 71, 79), // rgba(55,71,79 ,1)

void main() {
  runApp(MaterialApp(
    title: 'MC Coordinates',
    theme: ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Color.fromARGB(255, 33, 33, 33), // rgba(97,97,97 ,1)
      cardColor: Color.fromARGB(255, 55, 71, 79), // rgba(55,71,79 ,1)
      textTheme: TextTheme(
        body1: TextStyle(color: Colors.white),
      ),
    ),
    home: Worlds(),
  ));
}
