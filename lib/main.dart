import 'package:flutter/material.dart';
import './tabs.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './color_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'favorites.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE favorites(name TEXT, color1 TEXT, color2 TEXT, color3 TEXT, color4 TEXT)"
      );
    },
    version: 1
  );
  await database.then((value) => value.close());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
