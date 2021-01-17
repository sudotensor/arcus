import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './color_request.dart';

class RandImg {
  final String url;

  RandImg({this.url});

  factory RandImg.fromJson(Map<String, dynamic> json) {
    return RandImg(
      url: json["urls"]["raw"],
    );
  }
}

Future<RandImg> fetchImg() async {
  final response =
      await http.get("https://api.unsplash.com/photos/random", headers: {
    HttpHeaders.authorizationHeader:
        "Client-ID OC_8GFmPsPUtKdd9yZeKgYhXSZJ3BSBfmyIFUbLaoQ8"
  });

  if (response.statusCode == 200) {
    return RandImg.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Could not load Random Image");
  }
}

class RandomUnsplash extends StatefulWidget {
  @override
  _RandomUnsplashState createState() => _RandomUnsplashState();
}

class _RandomUnsplashState extends State<RandomUnsplash> {
  RandImg futureImg;
  PrimaryColors primaryColors;
  var _primaryColorsLen = 4;

  status() async {
    if(futureImg != null && primaryColors != null) {
      setState(() {});
    } else {
      status();
    }
    return null;
  }

  getImgData() async {
    futureImg = await fetchImg();
    primaryColors = await fetchPalette(futureImg.url);
    status();
    //setState(() {});
    return null;
  }

  refreshVars() {
    futureImg = null;
    primaryColors = null;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            children: [
              new Builder(
                  builder: (BuildContext context) {
              if(futureImg != null) {
                return Image.network(futureImg.url);
              }
              return Text("Click button to load image");
            }
            ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(4.0),
                itemCount: _primaryColorsLen,
                itemBuilder: (BuildContext context, int i) {
                  if(primaryColors != null) {
                    return Icon(Icons.circle, color: primaryColors.colors[i]);
                  }
                  return Text("");
                },
              )
            ],
          ),
          OutlinedButton(
            onPressed: () {
              refreshVars();
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Loading Image...")));
              getImgData();
            },
            child: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }
}
