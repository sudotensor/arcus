import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrimaryColors {
  var colors = [];

  PrimaryColors({this.colors});

  factory PrimaryColors.fromJson(Map<String, dynamic> json) {
    var expCols = [];
    for(var i=0; i<4; i++){
      expCols.add(Color.fromRGBO(
          json["responses"][0]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["red"],
          json["responses"][0]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["green"],
          json["responses"][0]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["blue"],
          1.0));
    }
    return PrimaryColors(colors: expCols);
  }
}

Future<PrimaryColors> fetchPalette(var imageUri) async {
  final body = {"requests" : [{"image" : {"source" : {"imageUri" : "$imageUri"}}, "features" : [{"maxResults" : 4, "type" : "IMAGE_PROPERTIES"},]}]};
  final token = "ya29.c.Kp0B7geKhdq3OSzfM_GBIl1E4F8LSwlFhfQDAzlM6D1_oROonyHmL7sGu7bmTXNGdS9Ef-XOD9qp6DH3ZnvrWCC-MzWLymgTNZ90r7nfP9esCajiQY2zrF_YPYe-5nu3P7sk5JaSa42Q_hbWfNWclCkzE608R0azYS0fnD08xPlcq2pbwJTMHE4z0iXMVdCRaDuhtNkS31Of17AgKNb8fA";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception("Could not load Searched Palette");
  }
}
