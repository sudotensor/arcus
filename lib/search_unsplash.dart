import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './color_request.dart';

class SearchImg {
  final String url;

  SearchImg({this.url});

  factory SearchImg.fromJson(Map<String, dynamic> json, var i) {
    return SearchImg(
      url: json["results"][i]["urls"]["raw"],
    );
  }
}

Future<SearchImg> fetchImg(var search, var i) async {
  final response = await http
      .get("https://api.unsplash.com/search/photos?query=$search", headers: {
    HttpHeaders.authorizationHeader:
        "Client-ID OC_8GFmPsPUtKdd9yZeKgYhXSZJ3BSBfmyIFUbLaoQ8"
  });

  if (response.statusCode == 200) {
    return SearchImg.fromJson(jsonDecode(response.body), i);
  } else {
    throw Exception("Could not load Searched Image");
  }
}

class SearchUnsplash extends StatefulWidget {
  @override
  _SearchUnsplashState createState() => _SearchUnsplashState();
}

class _SearchUnsplashState extends State<SearchUnsplash> {
  List<SearchImg> searchImgs = <SearchImg>[];
  final int _numImgs = 5;
  var searchTerm = "";
  final searchController = TextEditingController();
  List<PrimaryColors> primaryColors = <PrimaryColors>[];
  final int _primaryColorsLen = 4;

  status() async {
    if (searchImgs[0] != null && primaryColors[0] != null) {
      setState(() {});
    } else {
      status();
    }
    return null;
  }

  getImgData() async {
    for (var i = 0; i < _numImgs; i++) {
      searchImgs[i] = await fetchImg(searchTerm, i);
      print("got");
    }
    for (var i = 0; i < _numImgs; i++) {
      primaryColors[i] = await fetchPalette(searchImgs[i].url);
      print("got2");
    }
    status();
    //setState(() {});
    return null;
  }

  refreshVars() {
    for (var i = 0; i < _numImgs; i++) {
      searchImgs[i] = null;
    }
    for (var i = 0; i < _numImgs; i++) {
      primaryColors[i] = null;
    }
    return null;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(searchImgs.length);
    if (searchImgs.length == 0) {
      for (var i = 0; i < _numImgs; i++) {
        searchImgs.add(null);
      }
    }
    if (primaryColors.length == 0) {
      for (var i = 0; i < _numImgs; i++) {
        primaryColors.add(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextField(
                controller: searchController,
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                onPressed: () {
                  refreshVars();
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Searching for Images...")));
                  getImgData();
                },
                child: Icon(Icons.search),
              ))
        ]),
      ),
      Expanded(
          child: SizedBox(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(16.0),
                itemCount: _numImgs,
                itemBuilder: (BuildContext context, int index) {
                  if (searchImgs[0] != null && primaryColors[0] != null) {
                    return Column(
                      children: [
                        Image.network(searchImgs[index].url),
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(4.0),
                            itemCount: _primaryColorsLen,
                            itemBuilder: (BuildContext context, int i) {
                              return Icon(Icons.circle,
                                  color: primaryColors[index].colors[i]);
                            })
                      ],
                    );
                  }
                  return Text("");
                },
              )))
    ]);
  }
}
