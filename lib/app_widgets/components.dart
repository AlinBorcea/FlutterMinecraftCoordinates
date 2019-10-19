import 'package:flutter/material.dart';

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
