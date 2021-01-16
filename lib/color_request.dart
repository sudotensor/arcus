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
              int.parse(json["responses"]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["red"]),
              int.parse(json["responses"]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["green"]),
              int.parse(json["responses"]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["blue"]),
              1.0));
    }
    return PrimaryColors(colors: expCols);
  }
}

Future<PrimaryColors> fetchPalette(var imageUri) async {
  final body = {"requests" : [{"image" : {"source" : {"imageUri" : "$imageUri"}}, "features" : [{"maxResults" : 4, "type" : "IMAGE_PROPERTIES"},]}]};
  final token = "ya29.c.Kp0B7ge9g0FPgG0mVgrmpohLJ5Digdu_Sz_bwu_OvE7yYYNb_Rjgb45FZsLEDo-cAnyPhm70FI68iAcB3z9KU7vddboaxZij9cFyvDEuDQ51XtzOFQInKCt2IF1rcn2yL2smb0uA_BInAOdmbcRInfRYyoGbWHHh_E104WeRsoYfWw81Sfb1aubJ4ktxRhhRxDvaschlc7FbDFdYC4eZpg";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Could not load Searched Palette");
  }
}
