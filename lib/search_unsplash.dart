import 'package:arcus/color_request.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './palette_page.dart';

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
      .get("https://api.unsplash.com/search/photos?query={$search}", headers: {
    HttpHeaders.authorizationHeader:
        "Client-ID 7kXNn32J4W0djMR3eCOr96yVet3FTKw7Pl3GRk8SIeA"
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
  PrimaryColors primaryColors;

  status() async {
    if (searchImgs[0] != null) {
      setState(() {});
    } else {
      status();
    }
    return null;
  }

  getContent() async {
    for (var i = 0; i < _numImgs; i++) {
      searchImgs[i] = await fetchImg(searchTerm, i);
    }
    status();
    return null;
  }

  getPrimaryColors(SearchImg searchImg) async {
    primaryColors = await fetchPalette(searchImg.url);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (searchImgs.length == 0) {
      for (var i = 0; i < _numImgs; i++) {
        searchImgs.add(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Spacer(),
          Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextField(
                controller: searchController,
              )),
          Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
          Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: FlatButton(
                onPressed: () {
                  searchTerm = searchController.text;
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Loading Images...")));
                  getContent();
                },
                child: Icon(Icons.search, size: 50),
              )),
          Spacer(),
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
                  return Column(
                    children: [
                      searchImgs[index] != null ? Image.network(searchImgs[index].url)
                      : SizedBox(
                        child: Shimmer.fromColors (
                          baseColor: Colors.white,
                          highlightColor: Colors.grey,
                          child: Container (
                            child: Column(
                              children: <Widget> [
                                Container (
                                  height: 150,
                                  width: 400,
                                  decoration: BoxDecoration (
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(8.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      searchImgs[index] != null ? FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: Colors.black,
                        child: new Text(
                          'Create New Palette',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(1),
                          ),
                        ),
                        //onPressed: getImage,
                        onPressed: () async {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Loading Palette...")));
                            await getPrimaryColors(searchImgs[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PalettePage(primaryColors.colors)),
                            );
                        },
                      )
                      : SizedBox (
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey,
                          child: Container(
                            child: Column(
                              children: <Widget> [
                                Container(
                                  height: 150,
                                  width: 400,
                                  decoration: BoxDecoration (
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(8.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                     ],
                  );
                },
              )))
    ]);
  }
}
