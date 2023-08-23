import 'dart:convert';
import 'package:achiever/services/cryptography/encrypt.dart';
import 'package:achiever/services/liver_prediction%20ML%20Model/predict_service.dart';
import 'package:achiever/services/liver_prediction%20ML%20Model/resultScreen.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:achiever/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class formpage extends StatefulWidget {
  @override
  FormState createState() {
    return FormState();
  }
}

class FormState extends State<formpage> {
  final id = StorageService().getString("user_id");
  bool loading = false;

  final firestore = FirebaseFirestore.instance.collection("records");
  final firestoreSnapshot =
      FirebaseFirestore.instance.collection("records").snapshots();

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
  final PredictionService predictionService = PredictionService();
  String submitChange = StorageService().getString("ButtonName").isEmpty
      ? "Submit"
      : StorageService().getString("ButtonName");

  // Widget checkData() {
  //   return StreamBuilder(
  //       stream: firestoreSnapshot,
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Text("Loading");
  //         } else if (snapshot.data!.docs == id) {
  //           return Text("1");
  //         }
  //         return Text("0");
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> predictionResult = {};

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
              left: 15.sp, right: 15.sp, bottom: 15.sp, top: 50.sp),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, bottom: 25.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "User Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    )),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                        bleedController.text = "1";
                                      });
                                    },
                                    child: Text("Yes"),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        bleedController.text = "0";
                                      });
                                    },
                                    child: Text("No"),
                                  ),
                                ]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Bleed';
                        } else if (value == "Yes") {
                          setState(() {
                            bleedController.text = "1";
                          });
                        } else if (value == "No") {
                          setState(() {
                            bleedController.text = "0";
                          });
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
                                        cirrController.text = "1";
                                      });
                                    },
                                    child: Text("Yes"),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        cirrController.text = "0";
                                      });
                                    },
                                    child: Text("No"),
                                  ),
                                ]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Cirrhosis';
                        } else if (value == "Yes") {
                          setState(() {
                            bleedController.text = "1";
                          });
                        } else if (value == "No") {
                          setState(() {
                            bleedController.text = "0";
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    TextFormField(
                      controller: sizeController,
                      decoration: const InputDecoration(
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
                        hintText: 'Enter Yes or No',
                        labelText: 'Previous Known Cirrhosis',
                        border: OutlineInputBorder(),
                        suffixIcon: PopupMenuButton(
                            icon: Icon(Icons.arrow_drop_down),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        prevController.text = "1";
                                      });
                                    },
                                    child: Text("Yes"),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        prevController.text = "0";
                                      });
                                    },
                                    child: Text("No"),
                                  ),
                                ]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid previous Known Cirrhosis';
                        } else if (value == "Yes") {
                          setState(() {
                            bleedController.text = "1";
                          });
                        } else if (value == "No") {
                          setState(() {
                            bleedController.text = "0";
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: InkWell(
                  onTap: () async {
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
                      print("Application Id: ${id}");
                      setState(() {
                        loading = true;
                      });

                      Map<String, double> data = {
                        "Bleed": double.parse(bleedController.text),
                        "Cirrhosis": double.parse(cirrController.text),
                        "size": double.parse(sizeController.text),
                        "HCC_TNM_Stage": double.parse(hController.text),
                        "ICC_TNM_Stage": double.parse(iController.text),
                        "Survival_fromMDM":
                            double.parse(mdm_survivalController.text),
                        "Surveillance_effectiveness":
                            double.parse(sController.text),
                        "PS": double.parse(pController.text),
                        "Prev_known_cirrhosis":
                            double.parse(prevController.text),
                      };
                      try {
                        final result =
                            await predictionService.makePrediction(data);

                        setState(() {
                          predictionResult = result;
                          print(predictionResult);
                          StorageService().setString("prediction_result",
                              jsonEncode(predictionResult['prediction']));
                        });
                      } catch (error) {
                        print('Error: $error');
                      }
                      if (submitChange == 'Submit') {
                        firestore.doc(id).set({
                          "id": id,
                          "bleed":
                              bleedController.text,
                          "cirrhosis":
                              cirrController.text,
                          "size":
                              sizeController.text,
                          "HCC_TNM_Stage":
                              hController.text,
                          "ICC_TNM_Stage":
                              iController.text,
                          "Survival_fromMDM": 
                              mdm_survivalController.text,
                          "Surveillance_effectiveness":
                              sController.text,
                          "PS": pController.text,
                          "Prev_known_cirrhosis":
                              prevController.text,
                        }).then((value) {
                          setState(() {
                            loading = false;
                            submitChange = 'Update';
                            StorageService()
                                .setString("ButtonName", submitChange);
                          });

                          Utils().toastMessage("Succesfully Uploaded", true);
                          if (StorageService().getString('prediction_result') ==
                              "0") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          value: "0",
                                        )));
                          } else if (StorageService()
                                  .getString('prediction_result') ==
                              "1") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          value: "1",
                                        )));
                          }
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(error.toString(), false);
                        });
                      } else if (submitChange == 'Update') {
                        firestore.doc(id).update({
                          "id": id,
                          "bleed":
                              bleedController.text,
                          "cirrhosis":
                              cirrController.text,
                          "size":
                              sizeController.text,
                          "HCC_TNM_Stage":
                              hController.text,
                          "ICC_TNM_Stage":
                              iController.text,
                          "Survival_fromMDM": 
                              mdm_survivalController.text,
                          "Surveillance_effectiveness":
                              sController.text,
                          "PS": pController.text,
                          "Prev_known_cirrhosis":
                              prevController.text
                        }).then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage("Succesfully Updated", true);

                          if (StorageService().getString('prediction_result') ==
                              "0") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          value: "0",
                                        )));
                          } else if (StorageService()
                                  .getString('prediction_result') ==
                              "1") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          value: "1",
                                        )));
                          }
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(error.toString(), false);
                        });
                      }
                    } else {
                      Utils().toastMessage("Please enter Data", false);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Color(0xff50a387),
                    ),
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Center(
                            child: Text(
                              submitChange,
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontFamily: "Caveat-VariableFont_wght",
                                  color: Colors.white),
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                  'Prediction Result: ${StorageService().getString('prediction_result')}')
            ],
          ),
        ));
  }
}
