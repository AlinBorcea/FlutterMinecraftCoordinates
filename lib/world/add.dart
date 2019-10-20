import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:minecraft_coordinates/models/world.dart';
import 'package:minecraft_coordinates/database/firestore_helper.dart';

class Add extends StatefulWidget {
  @override
  State createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _seedController = new TextEditingController();
  String _playStyle = "Survival";
  Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            _topImage(MediaQuery.of(context).size),
            _inputField(_nameController, TextInputType.text, 'World name'),
            _inputField(_seedController, TextInputType.numberWithOptions(),
                'Seed (optional)'),

            /// Pick play style
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
              child: _dropDownButton(),
            ),

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
                      onPressed: () {},
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
  Widget _dropDownButton() {
    return DropdownButton<String>(
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

  Widget _topImage(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Image.asset(
          'assets/village.jpg',
          width: size.width * 0.95,
        ),
      ),
    );
  }

  Widget _inputField(
      TextEditingController controller, TextInputType inputType, String hint) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

  /// Helper functions
  void saveWorld() {
    if (_nameController.text != '') {
      if (_seedController.text == '') _seedController.text = '0';

      addWorld(new World(_nameController.text, _playStyle, _seedController.text,
          _color.hashCode));
    }
  }
}
