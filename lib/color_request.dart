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
  final token = "ya29.a0AfH6SMDpqsHt_MjL2GC5xC4-DNLzBHZYEYDuKXwr24u1gJfEfEZhvbu8AsWk-TfIOMqnBBSsEOvOQa15ryhNI0QpDWQqAw6kxaN_ZATCWs26WJBaPur7VLX436nV49JXup71vYOK6jiFsfRlKy-ajjXwV4YO64-2bp4lWtbT0aVePeyUXlaUwxGpKbKzCV8w4GJss7TacVDnJ_EuRsmA0PXfnlCLDytyANWUrE_m5phYPX9BZ5PkzGyuVq91Ortmw1uecq5q4QKiYbHIWW14";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception("Could not load Searched Palette");
  }
}
