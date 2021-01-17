import 'package:hexcolor/hexcolor.dart';
import 'package:quartet/quartet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './color_request.dart';
import './palette_page.dart';

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
    if (futureImg != null && primaryColors != null) {
      setState(() {});
    } else if (primaryColors == null && futureImg != null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          backgroundColor: Colors.black,
                          content: Container(
                              height: 50, 
            child: Text("Image too large, reloading..."))));
      refreshVars();
      getImgData();
      status();
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
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 8)),
              new Builder(builder: (BuildContext context) {
                if (futureImg != null) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(futureImg.url)),
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        height: MediaQuery.of(context).size.height * 0.4,
                      ));
                }
                return SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: Center(
                        child: new Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/undraw_searching_p5ux.png')),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      height: 300.0,
                    )));
              }),
            ],
          ),
          if (futureImg == null)
            Text(
              "Tap on the button below\nto generate a palette!",
              textAlign: TextAlign.center,
            ),
          if (futureImg != null) Padding(padding: EdgeInsets.only(top: 12)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(4),
                        height: 120.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                          color: primaryColors != null
                              ? primaryColors.colors[0]
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        )))),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(4),
                        height: 120.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                          color: primaryColors != null
                              ? primaryColors.colors[1]
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        )))),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(4),
                        height: 120.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                          color: primaryColors != null
                              ? primaryColors.colors[2]
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        )))),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(4),
                        height: 120.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                          color: primaryColors != null
                              ? primaryColors.colors[3]
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        )))),
                Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                Flexible(
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: FittedBox(
                          child: Text(
                              '${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[0])}', 6), 4, -1) : ' '}'.toUpperCase(),
                              style: TextStyle(
                                  color: primaryColors != null
                                      ? Colors.black
                                      : Colors.transparent)),
                        ),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                            child: Text(
                                '${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[1])}', 6), 4, -1) : ' '}'.toUpperCase(),
                                style: TextStyle(
                                    color: primaryColors != null
                                        ? Colors.black
                                        : Colors.transparent)),
                          ),
                        ))),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                            child: Text(
                                '${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[2])}', 6), 4, -1) : ' '}'.toUpperCase(),
                                style: TextStyle(
                                    color: primaryColors != null
                                        ? Colors.black
                                        : Colors.transparent)),
                          ),
                        ))),
                Flexible(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                            child: Text(
                                '${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[3])}', 6), 4, -1) : ' '}'.toUpperCase(),
                                style: TextStyle(
                                    color: primaryColors != null
                                        ? Colors.black
                                        : Colors.transparent)),
                          ),
                        ))),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
              ]),
          if (primaryColors != null)
            SafeArea(
                minimum: EdgeInsets.symmetric(horizontal: 16),
                child: ButtonTheme(
                    minWidth: double.infinity,
                    child: new FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      color: Colors.black,
                      child: new Text(
                        'Add to Favourites',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(1),
                        ),
                      ),
                      onPressed: () {
                        if (primaryColors != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PalettePage(colors: primaryColors.colors)),
                          );
                        } else {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("No Image Selected!")));
                        }
                      },
                    ))),
                    Spacer(),
          SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 16),
              child: ButtonTheme(
                  minWidth: double.infinity,
                  child: new FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.black,
                    child: new Text(
                      'Generate Random Palette',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(1),
                      ),
                    ),
                    onPressed: () {
                      refreshVars();
                      Scaffold.of(context).showSnackBar(SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          backgroundColor: Colors.black,
                          content: Container(
                              height: 50, child: Text("Loading Image..."))));
                      getImgData();
                    },
                  ))),
          Padding(padding: EdgeInsets.only(bottom: 8.0)),
        ],
      ),
    );
  }
}
