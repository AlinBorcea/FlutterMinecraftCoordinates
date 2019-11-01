import 'package:flutter/material.dart';
import 'package:minecraft_coordinates/models/coordinate.dart';
import 'package:minecraft_coordinates/app_widgets/stateless_widgets.dart';
import 'package:minecraft_coordinates/database/firestore_helper.dart';

class AddEditCoordinate extends StatefulWidget {
  final String _colName;
  final Coordinate _coordinate;

  AddEditCoordinate(this._colName, this._coordinate);

  @override
  State createState() => _AddEditCoordinateState();
}

class _AddEditCoordinateState extends State<AddEditCoordinate> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _xController = new TextEditingController();
  final TextEditingController _yController = new TextEditingController();
  final TextEditingController _zController = new TextEditingController();
  Color _color = Colors.green;

  @override
  void initState() {
    super.initState();
    if (widget._coordinate != null) {
      _nameController.text = widget._coordinate.name;
      _xController.text = widget._coordinate.x;
      _yController.text = widget._coordinate.y;
      _zController.text = widget._coordinate.z;
      _color = new Color(widget._coordinate.color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._coordinate != null
            ? widget._coordinate.name
            : 'Add coordinate'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            topImage(MediaQuery.of(context).size, 'assets/new_world.jpg'),
            inputField(_nameController, TextInputType.text, 'Name'),
            inputField(_xController, TextInputType.numberWithOptions(), 'x = '),
            inputField(_yController, TextInputType.numberWithOptions(), 'y = '),
            inputField(_zController, TextInputType.numberWithOptions(), 'z = '),

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

                  /// Save coordinate
                  Container(
                    margin: EdgeInsets.only(left: 2.0, right: 2.0),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        'Save coordinate',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        _saveEditCoordinate();
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

  void _saveEditCoordinate() {
    if (_dataIsValid()) {
      if (widget._coordinate == null)
        addCoordinate(
            widget._colName,
            new Coordinate(_nameController.text, _xController.text,
                _yController.text, _zController.text, _color.hashCode));
    }
  }

  bool _dataIsValid() {
    if (_nameController.text.isNotEmpty &&
        _xController.text.isNotEmpty &&
        _yController.text.isNotEmpty &&
        _zController.text.isNotEmpty) return true;

    return false;
  }
}
