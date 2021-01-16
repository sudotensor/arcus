import 'dart:math';

import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final List<String> favourites = <String>['Palette 1', 'Palette 2', 'Palette 3', 'Palette 4'];
  Random random = new Random(); //GENERATE RANDOM COLORS FOR PLACEHOLDER PALETTES

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favourites.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 70,
            color: Colors.white,
            child: Align(
                alignment: Alignment(-0.9, 0.0),
                child: Row(
                  children: <Widget> [
                    Text('${favourites[index]}'),
                    Icon(Icons.brightness_1, color: Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)),
                    Icon(Icons.brightness_1, color: Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)),
                    Icon(Icons.brightness_1, color: Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)),
                    Icon(Icons.brightness_1, color: Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)),
                  ]
                )
            ),
          );
        },
    );
  }
}