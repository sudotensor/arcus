import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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
  List<Future<SearchImg>> searchImgs = <Future<SearchImg>>[];
  final int _numImgs = 10;
  var searchTerm = "";
  final searchController = TextEditingController();

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
    for (var i = 0; i < _numImgs; i++) {
      searchImgs[i] = fetchImg(searchTerm, i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        TextFormField(
          controller: searchController,
        ),
        ElevatedButton(
          onPressed: () {
            searchTerm = searchController.text;
            setState(() {});
          },
          child: Icon(Icons.search),
        )
      ]),
      ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _numImgs,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: FutureBuilder<SearchImg>(
              future: searchImgs[index],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.network(snapshot.data.url);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          );
        },
      )
    ]);
  }
}
