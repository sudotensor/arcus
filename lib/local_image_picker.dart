import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          galleryFile = File(pickedFile.path);
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
                new RaisedButton(
                  child: new Text('Select Image from Gallery'),
                  onPressed: getImage,
                ),
                SizedBox(
                  height: 400.0,
                  width: 400.0,
                  child: galleryFile == null
                      ? Center(child: new Text('Sorry nothing selected!!'))
                      : Center(child: new Image.file(galleryFile)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
