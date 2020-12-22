import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPhotoScreen extends StatefulWidget {
  static const routeName = '/add_photo_screen';

  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  File _image;
  final picker = ImagePicker();
  String _uploadFileURL;
  CollectionReference imgColRef;

  @override
  void initState() {
    imgColRef = FirebaseFirestore.instance.collection('imageURLs');
    super.initState();
  }

  Future<void> _takePictureFromPhotoFolder() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = File(pickedFile.path);
    });

    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> _takePictureUsingCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = File(pickedFile.path);
    });

    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}');

    firebase_storage.UploadTask task = ref.putFile(_image);

    task.whenComplete(() async {
      print('File uploaded!');
      await ref.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadFileURL = fileURL;
        });
      }).whenComplete(() async {
        await imgColRef.add({'url': _uploadFileURL});
        print('Link added to the database!');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 150),
            FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text('Open camera'),
              textColor: Colors.black,
              onPressed: () {
                _takePictureUsingCamera().whenComplete(
                  () => showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Confirm Upload?'),
                      content: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(_image.path),
                              fit: BoxFit.cover),
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () {
                            uploadFile();
                            Navigator.of(context).pop();
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.folder,
                size: 100,
              ),
              label: Text('Browse folder'),
              textColor: Colors.black,
              onPressed: () {
                _takePictureFromPhotoFolder().whenComplete(
                  () => showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Confirm Upload?'),
                      content: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(_image.path),
                              fit: BoxFit.cover),
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () {
                            uploadFile();
                            Navigator.of(context).pop();
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
