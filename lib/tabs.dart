import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import './local_image_picker.dart';
import './favourites.dart';
import './random_unsplash.dart';
import './search_unsplash.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: Colors.red[600],
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: new AppBar(
                    elevation: 0,
                    flexibleSpace: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: new TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black,
                                indicator: DotIndicator(
                                  color: Colors.black,
                                  distanceFromCenter: 16,
                                  radius: 3,
                                  paintingStyle: PaintingStyle.fill,
                                ),
                                tabs: [
                                  Tab(icon: Icon(Icons.camera_alt_rounded)),
                                  Tab(icon: Icon(Icons.casino)),
                                  Tab(icon: Icon(Icons.search)),
                                  Tab(icon: Icon(Icons.favorite)),
                                ]),
                          )
                        ])),
                body: TabBarView(children: [
                  LocalImagePicker(),
                  RandomUnsplash(),
                  SearchUnsplash(),
                  Favourites(),
                ]))));
  }
}
