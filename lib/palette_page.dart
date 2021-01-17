import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quartet/quartet.dart';

class PalettePage extends StatelessWidget {
  PalettePage(this.colors);

  final List<dynamic> colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Palette Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Row(
            children: <Widget> [
              Padding(padding: EdgeInsets.all(8.0)),
              Flexible(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      height: 170.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                            color: colors != null ? colors[0] : Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          )))),
              Flexible(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      height: 170.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                            color: colors != null ? colors[1] : Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          )))),
              Flexible(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      height: 170.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                            color: colors != null ? colors[2] : Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          )))),
              Flexible(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      height: 170.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                            color: colors != null ? colors[3] : Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          )))),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
          Row(
            children: <Widget> [
              Padding(padding: EdgeInsets.all(8.0)),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: FittedBox(
                       child: Text('${slice(slice('${ColorToHex(colors[0])}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: FittedBox(
                        child: Text('${slice(slice('${ColorToHex(colors[1])}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: FittedBox(
                        child: Text('${slice(slice('${ColorToHex(colors[2])}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: FittedBox(
                        child: Text('${slice(slice('${ColorToHex(colors[3])}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
                      ),
                    ),
                  )),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.black,
                child: new Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(20.0)),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

            ],
          ),
        ],
      ),
    );
  }
}
