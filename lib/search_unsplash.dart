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
        "Client-ID ILl4MM3c5zfwnNYnzv1NHa0dXp9jqvpd8ADKhh1fYF4"
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
  final int numImgs = 5;
  var searchTerm = "";
  final searchController = TextEditingController();
  PrimaryColors primaryColors;

  status() async {
    if (searchImgs[0] != null) {
      print("yeah");
      setState(() {});
    } else {
      status();
    }
    return null;
  }

  getContent() async {
    for (var i = 0; i < numImgs; i++) {
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
      for (var i = 0; i < numImgs; i++) {
        searchImgs.add(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(children: <Widget>[
          Spacer(),
          Container(
              padding: EdgeInsets.only(right: 8, left: 8),
              height: 36,
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                  controller: searchController,
                  decoration: new InputDecoration(
                    filled: true,
                    hintText: 'Search...',
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(
                      bottom: 18, // HERE THE IMPORTANT PART
                      left: 8,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ))),
          Container(
              padding: EdgeInsets.only(right: 8),
              width: MediaQuery.of(context).size.width * 0.20,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.black,
                onPressed: () {
                  searchTerm = searchController.text;
                  Scaffold.of(context).showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      backgroundColor: Colors.black,
                      content: Container(
                          height: 50, child: Text("Loading Images..."))));
                  getContent();
                },
                child: Icon(Icons.search, size: 24, color: Colors.white),
              )),
          Spacer(),
        ]),
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: numImgs,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 12)),
                      searchImgs[index] != null
                          ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                searchImgs[index].url,
                                fit: BoxFit.cover,
                              ),
                            ))
                          : SizedBox(
                              child: Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                        width: 400,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(bottom: 12.0)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      searchImgs[index] != null
                          ? SafeArea(
                              minimum: EdgeInsets.symmetric(horizontal: 16),
                              child: ButtonTheme(
                                  minWidth: double.infinity,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
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
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text("Loading Palette...")));
                                      await getPrimaryColors(searchImgs[index]);
                                      if (primaryColors != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PalettePage(
                                                  colors:
                                                      primaryColors.colors)),
                                        );
                                      } else {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                backgroundColor: Colors.black,
                                                content: Container(
                                                    height: 50,
                                                    child: Text(
                                                        "Image too big!"))));
                                      }
                                    },
                                  )))
                          : SizedBox(
                              child: Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: 150,
                                        width: 400,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
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
