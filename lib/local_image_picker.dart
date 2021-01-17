import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LocalImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GalleryAccess ();
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

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    Future getImage() async {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery
      );

      setState(() {
        if (pickedFile != null) {
          galleryFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    return new Scaffold(
      body: new Builder(
        builder: (BuildContext context) {
          return Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                SizedBox(
                  height: 400.0,
                  width: 350.0,
                  child: galleryFile == null
                      ? Center(child: new Container (
                          height: 300.0,
                          width: 450.0,
                          color: Colors.transparent,
                          child: Image.asset('assets/undraw_Organize_photos_re_ogcy.png'),
                  ))
                      : Center(child: new Image.file(galleryFile)),
                ),
                Spacer(),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding (padding: EdgeInsets.all(15.0)),
                    Container(
                      height: 140.0,
                      width: 70.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                      )
                    )
                    ),
                    Padding (padding: EdgeInsets.all(10.0)),
                    Container(
                        height: 140.0,
                        width: 70.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(10),
                              ),
                            )
                        )
                    ),
                    Padding (padding: EdgeInsets.all(10.0)),
                    Container(
                        height: 140.0,
                        width: 70.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(10),
                              ),
                            )
                        )
                    ),
                    Padding (padding: EdgeInsets.all(10.0)),
                    Container(
                        height: 140.0,
                        width: 70.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(10),
                              ),
                            )
                        )
                    ),
                    Padding (padding: EdgeInsets.all(16.0)),
                  ]
                ),
                Spacer(),
                Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding (padding: EdgeInsets.all(15.0)),
                      Container(
                          height: 30.0,
                          width: 70.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.all(Radius.circular(10),
                                ),
                              ),
                            padding: EdgeInsets.all(7.0),
                            child: FittedBox(
                              child: Text('#FFFFFF'),
                            ),
                          ),
                      ),
                      Padding (padding: EdgeInsets.all(10.0)),
                      Container(
                          height: 30.0,
                          width: 70.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(10),
                                ),
                              ),
                            padding: EdgeInsets.all(7.0),
                            child: FittedBox(
                              child: Text('#FFFFFF'),
                            ),
                          )
                      ),
                      Padding (padding: EdgeInsets.all(10.0)),
                      Container(
                          height: 30.0,
                          width: 70.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(Radius.circular(10),
                                ),
                              ),
                            padding: EdgeInsets.all(7.0),
                            child: FittedBox(
                              child: Text('#FFFFFF'),
                            ),
                          )
                      ),
                      Padding (padding: EdgeInsets.all(10.0)),
                      Container(
                          height: 30.0,
                          width: 70.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(10),
                                ),
                              ),
                            padding: EdgeInsets.all(7.0),
                            child: FittedBox(
                              child: Text('#FFFFFF'),
                            ),
                          )
                      ),
                      Padding (padding: EdgeInsets.all(16.0)),
                    ]
                ),
                Spacer(),
                new ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent[100]),
                  ),
                  child: new Text(
                    '                             Add to Favourites                             ',
                    style: TextStyle(color: Colors.black.withOpacity(1),
                   ),
                  ),
                  //onPressed: getImage,
                ),
                new ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  child: new Text(
                    '                     Select Image from Gallery                      ',
                    style: TextStyle(color: Colors.white.withOpacity(1),
                    ),
                  ),
                  onPressed: getImage,
                ),
                Padding (padding: EdgeInsets.all(10.0)),
              ],
            ),
          );
        },
      ),
    );
  }
}