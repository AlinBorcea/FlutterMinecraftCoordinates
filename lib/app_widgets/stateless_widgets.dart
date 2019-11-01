import 'package:flutter/material.dart';

/// Simple icons
Widget loadingIcon() {
  return Column(
    children: <Widget>[
      Icon(Icons.cloud_download, color: Colors.deepOrange, size: 64.0,),
      Text('Loading...')
    ],
  );
}

Widget errorIcon() {
  return Row(
    children: <Widget>[
      Icon(Icons.error, color: Colors.deepOrange, size: 64.0,),
      Text('There has been an error retrieving data from cloud!\nPlease try again')
    ],
  );
}

Widget noDataIcon() {
  return Column(
    children: <Widget>[
      Icon(Icons.scatter_plot, color: Colors.deepOrange, size: 64.0,),
      Text('No data could be found'),
    ],
  );
}

/// Add/Edit world widgets that do not use setState
Widget topImage(Size size, String asset) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Image.asset(
        asset,
        width: size.width * 0.95,
      ),
    ),
  );
}

Widget inputField(
    TextEditingController controller, TextInputType inputType, String hint) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
    child: TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ),
  );
}
