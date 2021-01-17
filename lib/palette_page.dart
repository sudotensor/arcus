import 'package:arcus/color_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quartet/quartet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './favourites.dart';

class PalettePage extends StatefulWidget {
  final List<dynamic> colors;
  const PalettePage({Key key, this.colors}) : super(key: key);
  @override
  _PalettePageState createState() => _PalettePageState();
}

class _PalettePageState extends State<PalettePage> {
  final nameController = new TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

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
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8.0)),
              Flexible(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      height: 170.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                        color: widget.colors != null
                            ? widget.colors[0]
                            : Colors.transparent,
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
                        color: widget.colors != null
                            ? widget.colors[2]
                            : Colors.transparent,
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
                        color: widget.colors != null
                            ? widget.colors[2]
                            : Colors.transparent,
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
                        color: widget.colors != null
                            ? widget.colors[3]
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      )))),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
          Row(
            children: <Widget>[
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
                        child: Text(
                            '${slice(slice('${ColorToHex(widget.colors[0])}', 6), 1, -1)}',
                            style: TextStyle(fontSize: 40)),
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
                        child: Text(
                            '${slice(slice('${ColorToHex(widget.colors[1])}', 6), 1, -1)}',
                            style: TextStyle(fontSize: 40)),
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
                        child: Text(
                            '${slice(slice('${ColorToHex(widget.colors[2])}', 6), 1, -1)}',
                            style: TextStyle(fontSize: 40)),
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
                        child: Text(
                            '${slice(slice('${ColorToHex(widget.colors[3])}', 6), 1, -1)}',
                            style: TextStyle(fontSize: 40)),
                      ),
                    ),
                  )),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Name"
                    ),
                    controller: nameController,
                  )),
              Padding(padding: EdgeInsets.all(8.0)),
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
                onPressed: () async {
                  final Future<Database> db = openDatabase(join(await getDatabasesPath(), 'favorites.db'));
                  final palette = MyPalette(nameController.text, widget.colors[0], widget.colors[1], widget.colors[2], widget.colors[3]);
                  await insertColors(palette, await db);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(20.0)),
        ],
      ),
    );
  }
}
