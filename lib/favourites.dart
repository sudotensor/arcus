import 'package:flutter/material.dart';
import 'dart:math';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {

  List<_MyPalette> palettes = <_MyPalette>[
    _MyPalette('Palette1', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette2', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette3', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette4', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette5', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette6', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette7', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette8', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette9', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette10', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette11', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette12', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette13', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette14', randomColor(), randomColor(), randomColor(), randomColor()),
    _MyPalette('Palette15', randomColor(), randomColor(), randomColor(), randomColor()),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: palettes.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell (
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PopUpScreen()),
              );
            },
            child: Container(
              height: 70,
              color: Colors.white,
              child: Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Row(
                      children: <Widget> [
                        Padding(padding: EdgeInsets.all(8.0)),
                        Text('${palettes[index].name}'),
                        Spacer(),
                        Box(palettes[index].color1),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Box(palettes[index].color2),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Box(palettes[index].color3),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Box(palettes[index].color4),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Container(
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.centerRight,
                            icon: (Icon(Icons.cancel)),
                            color: Colors.black,
                            onPressed: () => _removePalette(index),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                      ]
                  )
              ),
            )
          );
        },
    );
  }
// Function that removes a selected palette
  void _removePalette (index) {
    setState((){
      palettes.removeAt(index);
    });
  }
}

class PopUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            }, // Handle your callback
            child: Text('clicky'),
          ),
        )
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
      height: 20,
      width: 20.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }
}

// Palette class with 1 name prop and 4 color props
class _MyPalette {
  const _MyPalette(this.name, this.color1, this.color2, this.color3, this.color4);

  final String name;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
}
//GENERATE RANDOM COLORS FOR PLACEHOLDER PALETTES
Color randomColor () {
  Random random = new Random();
  return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
