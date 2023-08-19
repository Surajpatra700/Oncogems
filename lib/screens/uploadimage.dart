

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:achiever/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/toast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef= FirebaseDatabase.instance.ref('Post');

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(
              height: 39,
            ),
            ElevatedButton(
                child: Center(child: Text('Upload')),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                      firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/profile/' +
                          StorageService().getString("user_id"));
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);

                  Future.value(uploadTask).then((value) async {
                    var newUrl = await ref.getDownloadURL();

                    databaseRef
                        .child(StorageService().getString("user_id"))
                        .set({'id': StorageService().getString("user_id"), 'image': newUrl.toString()}).then(
                            (value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage('Updated Succesfully',true);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString(), false);
                    setState(() {
                      loading = false;
                    });
                  });
                }
                )
          ],
        ),
      ),
    );
  }
}
