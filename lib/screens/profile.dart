// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:achiever/screens/authentications/signupPage.dart';
import 'package:achiever/screens/uploadimage.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                                    }, child: Text("Cancel")),
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
                              StorageService()
                                            .getString("name").isEmpty ? "Oncogems": StorageService()
                                            .getString("name"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 19.5.sp),
                            ))),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
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
                          child: ListTile(
                            // selected: true,
                            leading: Icon(
                              Icons.notifications,
                            ),
                            // selectedTileColor: Colors.grey.shade400,
                            tileColor: Colors.grey.shade400,
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
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 60.r,
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_640.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 5.h,
                      right: 0.w,
                      child: CircleAvatar(
                        backgroundColor: Color(0xff50a387),
                        radius: 18.r,
                        child: Center(
                          child: IconButton(
                              onPressed: (

                                  ) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadImageScreen()));
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
