// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:achiever/screens/homeScreen.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:achiever/services/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DoctorForm extends StatefulWidget {
  const DoctorForm({super.key});

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final proffesionController = TextEditingController();
  final experienceController = TextEditingController();
  final hospitalController = TextEditingController();
  final phoneController = TextEditingController();
  bool loading = false;
  File? _image;
  final picker = ImagePicker();
  final id = StorageService().getString("user_id");

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance.collection("Doctor");

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
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 45.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 65.r,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(65.r),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1612349316228-5942a9b489c2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                        fit: BoxFit.cover,
                        height: 140.h,
                        width: 140.w,
                      )),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Text(
                "Your Details",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  // icon: const Icon(Icons.calendar_today),

                  hintText: 'Enter name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: TextFormField(
                controller: bioController,
                decoration: const InputDecoration(
                  hintText: 'Bio',
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: TextFormField(
                controller: proffesionController,
                decoration: InputDecoration(
                    // icon: const Icon(Icons.calendar_today),

                    hintText: 'Working Proffesion',
                    labelText: 'Proffesion',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text("Medical Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Medical Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text("Radiation Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Radiation Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text("Surgical Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Surgical Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 4,
                                child: Text("Geriatric Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Geriatric Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 5,
                                child: Text("Gynecologist Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Gynecologist Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 6,
                                child: Text("Hematologist Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Hematologist Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 7,
                                child: Text("Neuro-Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Neuro-Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 8,
                                child: Text("Pediatric Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Pediatric Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 9,
                                child: Text("Thoracic Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Thoracic Oncologist";
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 10,
                                child: Text("Urologic Oncologist"),
                                onTap: () {
                                  setState(() {
                                    proffesionController.text =
                                        "Urologic Oncologist";
                                  });
                                },
                              ),
                            ])),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your proffesion';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: TextFormField(
                controller: experienceController,
                decoration: const InputDecoration(
                  // icon: const Icon(Icons.calendar_today),

                  hintText: 'Work experience',
                  labelText: 'Work experience',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your year of experience';
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: TextFormField(
                controller: hospitalController,
                decoration: const InputDecoration(
                  // icon: const Icon(Icons.calendar_today),

                  hintText: 'Hospital of work',
                  labelText: 'hospital',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hospital of work';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  // icon: const Icon(Icons.calendar_today),

                  hintText: 'Contact Number',
                  labelText: 'contact number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your number';
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "profile",
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: InkWell(
                      onTap: () {
                        getImageGallery();
                      },
                      child: Container(
                        height: 150.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: _image != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.file(_image!.absolute,fit: BoxFit.cover,))
                            : Center(child: Icon(Icons.image)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/doctorProfile/' +
                            StorageService().getString("user_id"));
                    firebase_storage.UploadTask uploadTask =
                        ref.putFile(_image!.absolute);
                    Future.value(uploadTask).then((value) async {
                      var newUrl = await ref.getDownloadURL();
                      firestore.doc(id).set({
                        "id": id,
                        "name": nameController.text,
                        "bio": bioController.text,
                        "proffession": proffesionController.text,
                        "work_experience": experienceController.text,
                        "hospital": hospitalController.text,
                        "photourl": newUrl.toString(),
                        "contactnumber": phoneController.text,
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage("Succesfully Submitted", true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(error.toString(), false);
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(maximumSize: Size(100.w, 55.h)),
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text("Submit")),
            ),
          ],
        ),
      ),
    );
  }
}
