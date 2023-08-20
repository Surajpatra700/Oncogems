// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_build_context_synchronously, unused_local_variable

import 'dart:io';

import 'package:achiever/screens/authentications/signupPage.dart';

import 'package:achiever/services/storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../services/toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  bool themeMode = false;
  final updateName = TextEditingController();
  final updateBio = TextEditingController();
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  final profile = StorageService().getString("profilePhoto");

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                leading: Icon(
                  Icons.dark_mode,
                ),
                tileColor: Colors.grey.shade200,
                title: Text("Dark Mode"),
                trailing: Switch(
                    activeColor: Color(0xff50a387),
                    value: themeMode,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          Get.changeTheme(ThemeData.dark());
                        }
                        Get.changeTheme(ThemeData.light());
                      });
                    }),
                onTap: () {
                  setState(() {
                    themeMode = !themeMode;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: ListTile(
              leading: Icon(
                Icons.notifications,
              ),
              tileColor: Colors.grey.shade200,
              title: Text("Notification"),
              trailing: Switch(
                  activeColor: Color(0xff50a387),
                  value: themeMode,
                  onChanged: (value) {
                    setState(() {
                      // themeMode = !themeMode;
                    });
                  }),
              onTap: () {
                setState(() {
                  // themeMode = !themeMode;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: ListTile(
              leading: Icon(
                Icons.logout,
              ),
              tileColor: Colors.grey.shade200,
              title: Text("logout"),
              onTap: () async {
                await auth.signOut();
                await StorageService().remove("user_id");
                Navigator.pop(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String name = "User";
    String bio = "Loreum Ipsum!";
    UserLoginResponseEntity userProfile = UserLoginResponseEntity();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff50a387), Colors.grey.shade300]),
            ),
            child: Center(
                child: Text(
              "here's always hope beyond what you see",
              style: TextStyle(
                  fontFamily: "Caveat-VariableFont_wght",
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp),
            )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 180.h),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.elliptical(20, 20))),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Center(
                        child: TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "",
                                titlePadding: EdgeInsets.only(top: 20),
                                contentPadding: EdgeInsets.all(20),
                                middleText:
                                    "Are you sure want to update your name ?", // middle text doesn't allow more than 3 lines of text therefore we use content.
                                confirm: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        name = updateName.text;
                                        StorageService()
                                            .setString("name", name);
                                      });

                                      Get.back();
                                    },
                                    child: Text("Confirm")),
                                cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel")),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Update Your Name"),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: TextFormField(
                                        controller: updateName,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // Get.dialog(Container(
                              //   height: 100.h,
                              //   width: 280.w,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text("Update Your Name"),
                              //       Padding(
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 15.w, vertical: 8.h),
                              //         child: TextFormField(
                              //           controller: updateName,
                              //           decoration: InputDecoration(
                              //             border: OutlineInputBorder(),
                              //           ),
                              //           onChanged: (value) {
                              //             setState(() {
                              //               name = value;
                              //             });
                              //           },
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ));
                            },
                            child: Text(
                              StorageService().getString("name").isEmpty
                                  ? "Oncogems"
                                  : StorageService().getString("name"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 19.5.sp),
                            ))),
                    // SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: 280.w,
                            child: Text(
                              StorageService().getString("bio").isEmpty
                                      ? "Loreum Ipsum!"
                                      : StorageService().getString("bio"),
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "",
                                titlePadding: EdgeInsets.only(top: 20),
                                contentPadding: EdgeInsets.all(20),
                                middleText:
                                    "Are you sure want to update your bio ?", // middle text doesn't allow more than 3 lines of text therefore we use content.
                                confirm: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        bio = updateBio.text;
                                        StorageService().setString("bio", bio);
                                      });

                                      Get.back();
                                    },
                                    child: Text("Confirm")),
                                cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel")),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Update Your Bio"),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: TextFormField(
                                        controller: updateBio,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            bio = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.edit,color: Color(0xff50a387),))
                      ],
                    ),
                    // SizedBox(
                    //   height: 0.h,
                    // ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ListTile(
                                leading: Icon(
                                  Icons.dark_mode,
                                ),
                                selected: true,
                                tileColor: Colors.grey.shade400,
                                title: Text("Dark Mode"),
                                trailing: Switch(
                                    activeColor: Color(0xff50a387),
                                    value: themeMode,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          Get.changeTheme(ThemeData.dark());
                                        }
                                        Get.changeTheme(ThemeData.light());
                                      });
                                    }),
                                onTap: () {
                                  setState(() {
                                    themeMode = !themeMode;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ListTile(
                                leading: Icon(
                                  Icons.dark_mode,
                                ),
                                selected: true,
                                tileColor: Colors.grey.shade400,
                                title: Text("Notifications"),
                                trailing: Switch(
                                    activeColor: Color(0xff50a387),
                                    value: themeMode,
                                    onChanged: (value) {
                                      // setState(() {
                                      //   // if (value == true) {
                                      //   //   Get.changeTheme(ThemeData.dark());
                                      //   // }
                                      //   // Get.changeTheme(ThemeData.light());
                                      // });
                                    }),
                                onTap: () {
                                  setState(() {
                                    // themeMode = !themeMode;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: ListTile(
                              selected: true,
                              leading: Icon(
                                Icons.logout,
                              ),
                              tileColor: Colors.grey.shade400,
                              title: Text("logout"),
                              onTap: () async {
                                await auth.signOut();
                                await StorageService().remove("user_id");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                    // Expanded(
                    //   child: GridView.builder(
                    //       itemCount: 2,
                    //       shrinkWrap: true,
                    //       gridDelegate:
                    //           SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 2),
                    //       itemBuilder: ((context, index) {
                    //         return Padding(
                    //           padding: EdgeInsets.all(10),
                    //           child: Container(
                    //             height: 70.h,
                    //             width: 100.w,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade200,
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(15))),
                    //             child: Center(
                    //               child: Text("hello"),
                    //             ),
                    //           ),
                    //         );
                    //       })),
                    // ),
                    // Column(
                    //   children: [

                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 130.h, bottom: 20.h),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),

                    // backgroundColor: Colors.grey.shade300,
                    // radius: 60.r,
                    child: profile.isNotEmpty
                        ? CircleAvatar(
                            radius: 60.r,
                            child: Image.network(
                              profile.toString(),
                              height: 140.h,
                              width: 140.w,
                              fit: BoxFit.cover,
                            ))
                        : Icon(Icons.person, size: 50),
                  ),
                  Positioned(
                      bottom: 5.h,
                      right: 0.w,
                      child: CircleAvatar(
                        backgroundColor: Color(0xff50a387),
                        radius: 18.r,
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                getImageGallery().then((value) {
                                  firebase_storage.Reference ref =
                                      firebase_storage.FirebaseStorage.instance
                                          .ref('/profile/' +
                                              StorageService()
                                                  .getString("user_id"));
                                  firebase_storage.UploadTask uploadTask =
                                      ref.putFile(_image!.absolute);

                                  Future.value(uploadTask).then((value) async {
                                    var newUrl = await ref.getDownloadURL();
                                    setState(() {
                                      StorageService()
                                          .setString("profilePhoto", newUrl);
                                    });

                                    // databaseRef
                                    //     .child(
                                    //         StorageService().getString("user_id"))
                                    //     .set({
                                    //   'id': StorageService().getString("user_id"),
                                    //   'image': newUrl.toString()
                                    // }).then((value) {
                                    //   setState(() {
                                    //     loading = false;
                                    //   });
                                    //   Utils().toastMessage(
                                    //       'Updated Succesfully', true);
                                    // }).onError((error, stackTrace) {
                                    //   print(error.toString());
                                    //   setState(() {
                                    //     loading = false;
                                    //   });
                                    // });
                                    Utils().toastMessage(
                                        'Updated Succesfully', true);
                                  }).onError((error, stackTrace) {
                                    Utils()
                                        .toastMessage(error.toString(), false);
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
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => bottomSheet());
        },
        child: Icon(
          Icons.info,
          color: Colors.white,
          size: 28.sp,
        ),
      ),
    );
  }
}
