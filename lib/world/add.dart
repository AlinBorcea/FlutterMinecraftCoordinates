import 'package:flutter/material.dart';

class Add extends StatefulWidget {

  @override
  State createState() => _AddState();
}

class _AddState extends State<Add> {

  final TextEditingController _nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a world'),),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Name',
              ),
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                debugPrint('Added new world!');
              },
            ),
          ],
        ),
      ),
    );
  }
}