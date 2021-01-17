import 'package:hexcolor/hexcolor.dart';
import 'package:quartet/quartet.dart';
import 'dart:io';
import 'package:arcus/color_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './palette_page.dart';

class LocalImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GalleryAccess();
  }
}

class GalleryAccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GalleryAccessState();
  }
}

class GalleryAccessState extends State<GalleryAccess> {
  File galleryFile;
  final picker = ImagePicker();
  PrimaryColors primaryColors;

  getPalette() async {
    primaryColors = await fetchLocalPalette(galleryFile);
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          galleryFile = File(pickedFile.path);
          getPalette();
        } else {
          print('No image selected.');
        }
      });
    }

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Builder(
        builder: (BuildContext context) {
          return Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 8)),
                SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: galleryFile == null ? 
                      Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/undraw_Organize_photos_re_ogcy.png')),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      height: 300.0,
                    )
                      : Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(galleryFile)),
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        height: MediaQuery.of(context).size.height * 0.4,
                      )),
                if (galleryFile == null)
                Text(
                  "Pick an image from your gallery\nto generate a palette!",
                  textAlign: TextAlign.center,
                ),
                if (galleryFile != null)
                Padding(padding: EdgeInsets.only(top: 12)),
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
                      Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
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
                              padding: EdgeInsets.symmetric(horizontal: 6),
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
                                padding: EdgeInsets.symmetric(horizontal: 6),
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
                                padding: EdgeInsets.symmetric(horizontal: 6),
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
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: FittedBox(
                                  child: Text(
                                      '${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[3])}', 6), 4, -1) : ' '}'.toUpperCase(),
                                      style: TextStyle(
                                          color: primaryColors != null
                                              ? Colors.black
                                              : Colors.transparent)),
                                ),
                              ))),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
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
                                    builder: (context) => PalettePage(
                                        colors: primaryColors.colors)),
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("No Image selected!")));
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
                            'Select Image from Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(1),
                            ),
                          ),
                          onPressed: getImage,
                        ))),
                Padding(padding: EdgeInsets.only(bottom: 8.0)),
              ],
            ),
          );
        },
      ),
    );
  }
}
