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
  Future<RandImg> futureImg;
  Future<PrimaryColors> primaryColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          FutureBuilder<RandImg>(
            future: futureImg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Image.network(snapshot.data.url),
                  FutureBuilder<PrimaryColors>(
                    future: primaryColors,
                    builder: (context, snapshot2) {
                      print(snapshot2);
                      if (snapshot2.hasData) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16.0),
                          itemCount: snapshot2.data.colors.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Text(snapshot2.data.colors[i]);
                          },
                        );
                      } else {
                        return Text("No Color data");
                      }
                    },
                  )
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
          OutlinedButton(
            onPressed: () async {
              futureImg = fetchImg();
              futureImg.then((value) {
                primaryColors = fetchPalette(value.url);
              });
              setState(() {});
            },
            child: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }
}
