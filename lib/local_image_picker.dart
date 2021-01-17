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
                SizedBox(
                  width: 350.0,
                  child: galleryFile == null
                      ? Center(
                          child: new Container(
                          height: 300.0,
                          color: Colors.transparent,
                          child: Image.asset(
                              'assets/undraw_Organize_photos_re_ogcy.png'),
                        ))
                      : Center(child: new Image.file(galleryFile)),
                ),
                Text(
                  "Pick an image from your gallery\nto generate a palette!",
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                Spacer(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                      Flexible(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.all(4),
                              height: 120.0,
                              color: Colors.transparent,
                              child: Container(
                                  decoration: BoxDecoration(
                                color: primaryColors != null ? primaryColors.colors[0] : Colors.transparent,
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
                                color: primaryColors != null ? primaryColors.colors[1] : Colors.transparent,
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
                                color: primaryColors != null ? primaryColors.colors[2] : Colors.transparent,
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
                                color: primaryColors != null ? primaryColors.colors[3] : Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              )))),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
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
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: FittedBox(
                                child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[0])}', 6), 1, -1) : ' '}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
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
                                  child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[1])}', 6), 1, -1) : ' '}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
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
                                  child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[2])}', 6), 1, -1) : ' '}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
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
                                  child: Text('${primaryColors != null ? slice(slice('${ColorToHex(primaryColors.colors[3])}', 6), 1, -1) : ' '}' , style: TextStyle(color: primaryColors != null ? Colors.black : Colors.transparent)),
                                ),
                              ))),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                    ]),
                Padding(padding: EdgeInsets.only(top: 16)),
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
                          onPressed: (){
                            if(primaryColors != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    PalettePage(primaryColors.colors)),
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("No Image selected!")));
                            }
                          },
                        ))
                ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
