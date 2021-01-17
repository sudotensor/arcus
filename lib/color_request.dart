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
  final token = "ya29.c.Kp0B7geI4WTlgVTjo-KLiJz52Q8J7gxn2qzKL8mQGdpOQjK6TPsa3MFRDlXfDLvnfmbSSk8h0GVN-Pmogs0PDNeI6g_IbBJSq22W54WCl1YqTpT1ELICLD5zI99cB0gO2qjWTHFeD6f5679EUwLE2lDrNJQr-1P4_28VGCRz_Bfp8YS18n_gkUO2zYmeaduJCxa4aWbSV96EFdAw31IDmA";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception("Could not load Searched Palette");
  }
}
