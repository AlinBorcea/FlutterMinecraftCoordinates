import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'package:minecraft_coordinates/database/firestore_helper.dart';
import 'package:minecraft_coordinates/app_widgets/stateless_widgets.dart';

class AddEditWorld extends StatefulWidget {
  AddEditWorld(this._world);

  final World _world;

  @override
  State createState() => _AddEditWorldState();
}

class _AddEditWorldState extends State<AddEditWorld> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _seedController = new TextEditingController();
  String _playStyle = "Survival";
  Color _color = Colors.green;

  @override
  void initState() {
    super.initState();
    if (widget._world != null) {
      _nameController.text = widget._world.name;
      _seedController.text = widget._world.seed;
      _playStyle = widget._world.playStyle;
      _color = new Color(widget._world.color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            topImage(MediaQuery.of(context).size),
            inputField(_nameController, TextInputType.text, 'World name'),
            inputField(_seedController, TextInputType.numberWithOptions(),
                'Seed (optional)'),
            _dropDownGameMode(),

            /// Pick color
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
              child: RaisedButton(
                child: Text(
                  'Pick color',
                  style: TextStyle(color: Colors.white),
                ),
                color: _color,
                onPressed: () {
                  _pickColor(context);
                },
              ),
            ),

            /// Cancel
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  /// Save world
                  Container(
                    margin: EdgeInsets.only(left: 2.0, right: 2.0),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        'Save world',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        _addEditWorld();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Ui elements of the page
  Widget _dropDownGameMode() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0),
      child: DropdownButton<String>(
        value: _playStyle,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.green),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String newValue) {
          setState(() {
            _playStyle = newValue;
          });
        },
        items: <String>['Survival', 'Creative', 'Hardcore']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<Widget> _pickColor(BuildContext context) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Pick world color'),
        content: MaterialPicker(
          pickerColor: _color,
          onColorChanged: (color) {
            setState(() {
              _color = color;
            });
          },
        ),
        actions: <Widget>[
          FlatButton(
            textColor: _color,
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void _addEditWorld() {
    if (_dataIsValid()) {
      if (widget._world == null)
        addWorld(new World(_nameController.text, _playStyle,
            _seedController.text, _color.hashCode));
      else
        updateWorld(
            widget._world.name,
            new World(_nameController.text, _playStyle, _seedController.text,
                _color.hashCode));

      Navigator.of(context).pop();
    } else {
      _showAppDialog(context, 'Data is invalid!');
    }
  }

  /// Helper functions of helper functions
  bool _dataIsValid() {
    if (_seedController.text == '') _seedController.text = '0';
    return _nameController.text != '';
  }

  Future<void> _showAppDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
