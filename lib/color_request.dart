import 'package:arcus/favourites.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PrimaryColors {
  final colors;

  PrimaryColors({this.colors});

  factory PrimaryColors.fromJson(Map<String, dynamic> json) {
    var expCols = [];
    for(var i=0; i<4; i++){
      print(json);
      if(json["responses"][0]["error"] == null) {
        expCols.add(Color.fromRGBO(
            json["responses"][0]["imagePropertiesAnnotation"]
            ["dominantColors"]["colors"][i]["color"]["red"],
            json["responses"][0]["imagePropertiesAnnotation"]
            ["dominantColors"]["colors"][i]["color"]["green"],
            json["responses"][0]["imagePropertiesAnnotation"]
            ["dominantColors"]["colors"][i]["color"]["blue"],
            1.0));
      } else {
        return null;
      }
    }
    return PrimaryColors(colors: expCols);
  }
}

Future<void> insertColors(MyPalette palette, Database database) async {
  final Database db = await database;
  await db.insert(
    'favorites',
    palette.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace
  );
}

Future<PrimaryColors> fetchLocalPalette(var imageFile) async {
  List fileBytes = await imageFile.readAsBytesSync();
  String encodedFile = base64.encode(fileBytes);
  final body = {"requests" : [{"image" : {"content" : "$encodedFile"}, "features" : [{"maxResults" : 4, "type" : "IMAGE_PROPERTIES"}]}]};
  final token = "ya29.c.Kp0B7gdO1RBfjxxNX_S5_c8GTca88RK0LovCqLdMiO8GetPocnA2KRVV1fPOekIM35mckB7U6mADcpbysVemYb0wGt5Ts_xulWrqDZndnz4spN4KLA_y92Yqrw2rH0Hcl6WnaoubetTiiM3bKxqlTybSEPRkLCKzvQK06rI5p8G5_9HKDULfqnLBsNPyejBJsByCkywSt_DnX-G74Ca8OQ";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    return null;
  }
}

Future<PrimaryColors> fetchPalette(var imageUri) async {
  final body = {"requests" : [{"image" : {"source" : {"imageUri" : "$imageUri"}}, "features" : [{"maxResults" : 4, "type" : "IMAGE_PROPERTIES"},]}]};
  final token = "ya29.c.Kp0B7gdO1RBfjxxNX_S5_c8GTca88RK0LovCqLdMiO8GetPocnA2KRVV1fPOekIM35mckB7U6mADcpbysVemYb0wGt5Ts_xulWrqDZndnz4spN4KLA_y92Yqrw2rH0Hcl6WnaoubetTiiM3bKxqlTybSEPRkLCKzvQK06rI5p8G5_9HKDULfqnLBsNPyejBJsByCkywSt_DnX-G74Ca8OQ";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
