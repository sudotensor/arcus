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
    } else if(primaryColors == null && futureImg != null) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Image too large, reloading...")));
      refreshVars();
      getImgData();
      status();
    }else {
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
        // child: Image.asset('assets/undraw_searching_p5ux'),
        children: [
          Column(
            children: [
              new Builder(
                  builder: (BuildContext context) {
                    if(futureImg != null) {
                      return Container(
                        height: MediaQuery.of(context).size.height*0.5,
                        child: Image.network(futureImg.url, fit: BoxFit.fitHeight)
                      );
                    }
                    return Text('');
                  }
              ),
            ],
          ),
          Spacer(),
          Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                          color: primaryColors != null ? primaryColors.colors[0] : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        )
                    )
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                          color: primaryColors != null ? primaryColors.colors[1] : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        )
                    )
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                          color: primaryColors != null ? primaryColors.colors[2] : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        )
                    )
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                          color: primaryColors != null ? primaryColors.colors[3] : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        )
                    )
                ),
              ]
          ),
          Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.15,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.transparent),
                        left: BorderSide(width: 1.0, color: Colors.transparent),
                        right: BorderSide(width: 1.0, color: Colors.transparent),
                        bottom: BorderSide(width: 1.0, color: Colors.transparent),
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.all(7.0),
                    child: FittedBox(
                      child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[0])}', 6), 1, -1) : ''}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.transparent),
                          left: BorderSide(width: 1.0, color: Colors.transparent),
                          right: BorderSide(width: 1.0, color: Colors.transparent),
                          bottom: BorderSide(width: 1.0, color: Colors.transparent),
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.all(7.0),
                      child: FittedBox(
                        child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[1])}', 6), 1, -1) : ''}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
                      ),
                    )
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.transparent),
                          left: BorderSide(width: 1.0, color: Colors.transparent),
                          right: BorderSide(width: 1.0, color: Colors.transparent),
                          bottom: BorderSide(width: 1.0, color: Colors.transparent),
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.all(7.0),
                      child: FittedBox(
                        child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[2])}', 6), 1, -1) : ''}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
                      ),
                    )
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.15,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.transparent),
                          left: BorderSide(width: 1.0, color: Colors.transparent),
                          right: BorderSide(width: 1.0, color: Colors.transparent),
                          bottom: BorderSide(width: 1.0, color: Colors.transparent),
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.all(7.0),
                      child: FittedBox(
                        child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[3])}', 6), 1, -1) : ''}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
                      ),
                    )
                ),
              ]
          ),
          FlatButton(
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
            //onPressed: getImage,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PalettePage(primaryColors.colors)),
              );
            },
          ),
          new FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.black,
            child: new Text(
              'Generate New Palette',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(1),
              ),
            ),
            onPressed: () {
              refreshVars();
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Loading Image...")));
              getImgData();
            },
          ),
        ],
      ),
    );
  }
}