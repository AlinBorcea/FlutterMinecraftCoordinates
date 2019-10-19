import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';

class Add extends StatefulWidget {
  @override
  State createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _nameController = new TextEditingController();
  final String pathImg = 'assets/village.jpg';
  Color _color = Colors.orange;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  pathImg,
                  width: size.width * 0.95,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: _color,
                  hoverColor: _color,
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
              child: RaisedButton(
                child: Text(
                  'Pick color',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.orange,
                onPressed: () {
                  _pickColor(context);
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: FlatButton(
                        child: Text('Cancel', style: TextStyle(color: Colors.white),),
                        color: Colors.orange,
                        onPressed: () {
                          debugPrint('world/add.dart -> cancel');
                        },
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2.0, right: 2.0),
                  ),
                  Expanded(
                      child: FlatButton(
                        child: Text('Save world', style: TextStyle(color: Colors.white),),
                        color: Colors.orange,
                        onPressed: () {
                          debugPrint('world/add.dart -> save world');
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
}
