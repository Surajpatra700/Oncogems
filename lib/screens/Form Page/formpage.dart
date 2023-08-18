// ignore_for_file: unrelated_type_equality_checks

import 'package:achiever/screens/homeScreen.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:achiever/services/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class formpage extends StatefulWidget {
  //class MyCustomForm extends StatefulWidget {
  @override
  FormState createState() {
    return FormState();
  }
}

class FormState extends State<formpage> {
  final id = StorageService().getString("user_id");
  bool loading = false;
  // String id = DateTime.now().microsecondsSinceEpoch.toString();
  //@override
  // void initState() {
  //   super.initState();
  //   id = value;
  // }

  // final id = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance.collection("records");
  final firestoreSnapshot =
      FirebaseFirestore.instance.collection("records").snapshots();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final bleedController = TextEditingController();
  final cirrController = TextEditingController();
  final hController = TextEditingController();
  final iController = TextEditingController();
  final sController = TextEditingController();
  final pController = TextEditingController();
  final prevController = TextEditingController();
  final mdm_survivalController = TextEditingController();
  final sizeController = TextEditingController();

  Widget checkData() {
    return StreamBuilder(
        stream: firestoreSnapshot,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else if (snapshot.data!.docs == id) {
            return Text("1");
          }
          return Text("0");
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
      padding:
          EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 15.sp, top: 50.sp),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0.h,bottom: 25.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("User Details",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),)),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: bleedController,
                  decoration: InputDecoration(
                    hintText: 'Yes/No',
                    labelText: 'Bleed',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    bleedController.text = "Yes";
                                  });
                                },
                                child: Text("Yes"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    bleedController.text = "No";
                                  });
                                },
                                child: Text("No"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Bleed';
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextFormField(
                  controller: cirrController,
                  decoration: InputDecoration(
                    hintText: 'Enter cirrhosis',
                    labelText: 'Cirrhosis',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    cirrController.text = "Yes";
                                  });
                                },
                                child: Text("Yes"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    cirrController.text = "No";
                                  });
                                },
                                child: Text("No"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Cirrhosis';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),

                TextFormField(
                  controller: sizeController,
                  decoration: const InputDecoration(
                    // icon: const Icon(Icons.calendar_today),

                    hintText: 'Enter size of tumor',
                    labelText: 'Size',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid size';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),
                TextFormField(
                  controller: hController,
                  decoration: InputDecoration(
                    // icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter your HCC TNM Stage',
                    labelText: 'HCC TNM Stage',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    hController.text = "0";
                                  });
                                },
                                child: Text("0"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    hController.text = "1";
                                  });
                                },
                                child: Text("1"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    hController.text = "2";
                                  });
                                },
                                child: Text("2"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    hController.text = "3";
                                  });
                                },
                                child: Text("3"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid HCC TNM Stage';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),
                TextFormField(
                  controller: iController,
                  decoration: InputDecoration(
                    //icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter your ICC TNM Stage',
                    labelText: 'ICC TNM Stage',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    iController.text = "0";
                                  });
                                },
                                child: Text("0"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    iController.text = "1";
                                  });
                                },
                                child: Text("1"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    iController.text = "2";
                                  });
                                },
                                child: Text("2"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    iController.text = "3";
                                  });
                                },
                                child: Text("3"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid ICC TNM Stage';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),
                TextFormField(
                  controller: mdm_survivalController,
                  decoration: const InputDecoration(
                    //icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter Survival From MDM',
                    labelText: 'Survival From MDM',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid Survival From MDM';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),
                TextFormField(
                  controller: sController,
                  decoration: InputDecoration(
                    //  icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter Surveillance effectiveness',
                    labelText: 'Surveillance effectiveness',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    sController.text = "0";
                                  });
                                },
                                child: Text("0"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    sController.text = "1";
                                  });
                                },
                                child: Text("1"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    sController.text = "2";
                                  });
                                },
                                child: Text("2"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid Surveillance effectiveness';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),

                TextFormField(
                  controller: pController,
                  decoration: InputDecoration(
                    //  icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter PS',
                    labelText: 'PS',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    pController.text = "0.0";
                                  });
                                },
                                child: Text("0.0"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    pController.text = "1.0";
                                  });
                                },
                                child: Text("1.0"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    pController.text = "2.0";
                                  });
                                },
                                child: Text("2.0"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid PS';
                    }
                  },
                ),
                SizedBox(
                  height: 15.sp,
                ),
                TextFormField(
                  controller: prevController,
                  decoration: InputDecoration(
                    //   icon: const Icon(Icons.calendar_today),
                    hintText: 'Previous Known Cirrhosis',
                    labelText: 'Enter Yes or No',
                    border: OutlineInputBorder(),
                    suffixIcon: PopupMenuButton(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    prevController.text = "Yes";
                                  });
                                },
                                child: Text("Yes"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    prevController.text = "No";
                                  });
                                },
                                child: Text("No"),
                              ),
                            ]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid previous Known Cirrhosis';
                    }
                  },
                ),
                // Container(
                //     padding: const EdgeInsets.only(left: 130.0, top: 40.0),
                //     child: ElevatedButton(
                //       child: const Text('Submit'),
                //       onPressed: () {
                //         // It returns true if the form is valid, otherwise returns false
                //
                //         if (_formKey.currentState) {
                //           // If the form is valid, display a Snackbar.
                //           // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data is in processing.')));
                //           Get.snackbar("Oncogems", "Data is in processing");
                //         }
                //       },
                //     )),
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    minimumSize: const Size(240, 48),
                    backgroundColor: const Color(0xff50a387),
                    padding: const EdgeInsets.symmetric(horizontal: 55)),
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        checkData().toString() == "1" ? 'Update' : 'Submit',
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontFamily: "Caveat-VariableFont_wght"),
                      ),
                onPressed: () {
                  if (bleedController.text != null &&
                      cirrController.text != null &&
                      sizeController.text != null &&
                      hController.text != null &&
                      iController.text != null &&
                      mdm_survivalController.text != null &&
                      sController.text != null &&
                      pController.text != null &&
                      prevController.text != null) {
                    Get.snackbar("Oncogems", "Data is processing");
                    setState(() {
                      loading = true;
                    });

                    // UPDATING DATA IN FIRESTORE DB

                    if (checkData().toString() == "1") {
                      firestore.doc(id).update({
                        "id": id,
                        "bleed": bleedController.text,
                        "cirrhosis": cirrController.text,
                        "size": sizeController.text,
                        "HCC_TNM_Stage": hController.text,
                        "ICC_TNM_Stage": iController.text,
                        "Survival_fromMDM": mdm_survivalController.text,
                        "Surveillance_effectiveness": sController.text,
                        "PS": pController.text,
                        "Prev_known_cirrhosis": prevController.text,
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage("Succesfully Updated", true);
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
                    }

                    // INSERTING DATA TO FIRESTORE DB

                    firestore.doc(id).set({
                      "id": id,
                      "bleed": bleedController.text,
                      "cirrhosis": cirrController.text,
                      "size": sizeController.text,
                      "HCC_TNM_Stage": hController.text,
                      "ICC_TNM_Stage": iController.text,
                      "Survival_fromMDM": mdm_survivalController.text,
                      "Surveillance_effectiveness": sController.text,
                      "PS": pController.text,
                      "Prev_known_cirrhosis": prevController.text,
                    }).then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage("Succesfully Uploaded", true);
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
                  } else {
                    Utils().toastMessage("Please enter Data", false);
                  }
                },
              )),
        ],
      ),
    ));
  }
}
