import 'package:arcus/color_request.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hexcolor/hexcolor.dart';
import 'package:quartet/quartet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Favourites extends StatefulWidget {
  final Database db;
  const Favourites({Key key, this.db}) : super(key: key);
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<MyPalette> paletteList = [];

  status() async {
    if(paletteList.length > 1) {
      setState(() {});
    } else {
      getPrimaryColors();
    }
  }

  getPrimaryColors() async {
    final palettesArr = await palettes();
    if(paletteList.length < 1) {
      for (var i = 0; i < palettesArr.length; i++) {
        paletteList.add(palettesArr[i]);
      }
    }
    status();
    return null;
  }

  nullify() {
    paletteList = [];
  }

  @override
  void initState() {
    super.initState();
    nullify();
    getPrimaryColors();
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: paletteList.length > 0 ? paletteList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell (
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PopUpScreen(paletteList, index)),
              );
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Column (
                    children: <Widget>[
                      Container(
                        child: Column (
                          children: <Widget>[
                            Row(
                                children: <Widget> [
                                  Padding(padding: EdgeInsets.all(8.0)),
                                  Text('${paletteList[index].name}', style: TextStyle(decoration: TextDecoration.underline, fontSize: 20.0,)),
                                  Spacer(),
                                  Container(
                                    child: IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: (Icon(Icons.cancel)),
                                      color: Colors.black,
                                      onPressed: () => _removePalette(index),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(2.0)),
                                ]
                            ),
                            Row(
                                children: <Widget> [
                                  Spacer(),
                                  Box(paletteList[index].color1),
                                  Spacer(),
                                  Box(paletteList[index].color2),
                                  Spacer(),
                                  Box(paletteList[index].color3),
                                  Spacer(),
                                  Box(paletteList[index].color4),
                                  Spacer(),
                                ]
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
              margin: const EdgeInsets.all(5.0),
            ),
          );
        },
    )
    );
  }
// Function that removes a selected palette
  void _removePalette (index) {
    setState((){
      paletteList.removeAt(index);
    });
  }
}

class PopUpScreen extends StatelessWidget {
  final List<MyPalette> palettes;
  final int index;
  PopUpScreen(this.palettes, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Padding(padding: EdgeInsets.all(30.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${palettes[index].name}', style: TextStyle(fontSize: 40)),
            ]
          ),
          Padding(padding: EdgeInsets.all(15.0)),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: palettes[index].color1,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${slice(slice('${ColorToHex(palettes[index].color1)}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
              ]
          ),
          Spacer(),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: palettes[index].color2,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${slice(slice('${ColorToHex(palettes[index].color2)}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
              ]
          ),
          Spacer(),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: palettes[index].color3,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${slice(slice('${ColorToHex(palettes[index].color3)}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
              ]
          ),
          Spacer(),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: palettes[index].color4,
                  ),
                ),
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${slice(slice('${ColorToHex(palettes[index].color4)}', 6), 1, -1)}', style: TextStyle(fontSize: 40)),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                  minimum: EdgeInsets.symmetric(horizontal: 16),
                  child: ButtonTheme(
                      child: new FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.black,
                        child: new Text(
                          'Go Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(1),
                            fontSize: 20.0
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                      ))),
            ]
          ),
          Spacer(),
        ],
      )
    );
  }
}

// Prints a box widget according to the color passed to it
class Box extends StatelessWidget {
  Box(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: 70.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}

// Palette class with 1 name prop and 4 color props
class MyPalette {
  const MyPalette(this.name, this.color1, this.color2, this.color3, this.color4);

  final String name;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "color1" : color1.toString(),
      "color2" : color2.toString(),
      "color3" : color3.toString(),
      "color4" : color4.toString()
    };
  }
}

Future<List<MyPalette>> palettes() async {
  final Database db = await openDatabase(join(await getDatabasesPath(), 'favorites.db'));

  final List<Map<String, dynamic>> maps = await db.query('favorites');

  return List.generate(maps.length, (i) {
    return MyPalette(
        maps[i]["name"],
        Color(int.parse(maps[i]["color1"].split('(0x')[1].split(')')[0], radix: 16)),
        Color(int.parse(maps[i]["color2"].split('(0x')[1].split(')')[0], radix: 16)),
        Color(int.parse(maps[i]["color3"].split('(0x')[1].split(')')[0], radix: 16)),
        Color(int.parse(maps[i]["color4"].split('(0x')[1].split(')')[0], radix: 16)));
  });
}
