import 'package:minecraft_coordinates/app_widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/world/worlds.dart';

void main() {
  runApp(MaterialApp(
    title: 'MC Coordinates',
    theme: ThemeData(
      primarySwatch: Colors.orange,
    ),
    home: Worlds(),
  ));
}
