import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PalettePage extends StatelessWidget {
  PalettePage(this.url, this.colors);

  final String url;
  final List<dynamic> colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Palette Page"),
      ),
      body: Center(
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
          color: Colors.black,
          child: new Text(
            'Go back',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(1),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}