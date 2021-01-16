import 'package:flutter/material.dart';
import './local_image_picker.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                    bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.settings)),
                          Tab(icon: Icon(Icons.settings)),
                        ]
                    ),
                    title: Text('Arcus')
                ),
                body: TabBarView (
                    children: [
                      LocalImagePicker(),
                      Text('Nothing to see here....'),
                    ]
                )
            )
        )
    );
  }
}