import 'dart:io';

class PrimaryColors {
  final colors = List<Color>;

  PrimaryColors({this.colors});

  factory PrimaryColors.fromJson(Map<String, dynamic> json) {
    expCols = List<Color>;
    for(var i=0; i<4; i++){
        expCols.add(Color.fromRGBO(
              parseInt(json["responses"]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["red"]),
              parseInt(json["responses"]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["green"]),
              parseInt(json["responses"]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["blue"]),
              1.0));
    }
    return PrimaryColors(expCols);
  }
}


Future<PrimaryColors> fetchPalette(var imageUri) async {
  final body = {"requests" : [{"image" : {"source" : {"gcsImageUri" : "{$imageUri}"}}, "features" : [{"maxResults" : 4, "type" : "IMAGE_PROPERTIES"},]}]};
  final token = "ya29.c.Kp0B7gdXr6Ss11wfBLrWjOhmeOszRW68xeqIi3eqmYPvyhhtUNHrTS4158aXwMUJqYKd3aExagBvkyeHqG6w1ztQFwr3fnvRGfQoiOYH1vUMYg3_9xevU4yIPSXau6C2-JvpeUVQEWhBCGiIzpWeSIwqtOGyR51_ot6kY0El5m4dTdxBTsciM14SZB5-NK6PrbK_3m0zf9wMiBThsRMLbA";
  final headers = {"Content-Type" : "application/json", "Authorization" : "Bearer {$token}"}
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body, headers);

  return PrimaryColors.fromJson(response);
}

