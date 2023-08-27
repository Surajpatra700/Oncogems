import 'package:achiever/screens/booking_Screens/confirmationpage.dart';
import 'package:achiever/services/liver_prediction%20ML%20Model/predict_service.dart';
import 'package:achiever/services/storage_services.dart';
import 'package:achiever/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class bookingpage extends StatefulWidget {
  @override
  bookingState createState() {
    return bookingState();
  }
}

class bookingState extends State<bookingpage> {
  final id = StorageService().getString("user_id");
  bool loading = false;

  final firestore = FirebaseFirestore.instance.collection("doctorbooking");
  final firestoreSnapshot =
      FirebaseFirestore.instance.collection("doctorbooking").snapshots();

  final _bookingKey = GlobalKey<bookingState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  final PredictionService predictionService = PredictionService();
  String submitChange = StorageService().getString("ButtonName").isEmpty
      ? "Submit"
      : StorageService().getString("ButtonName");

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
                      "Book Date and Time Slot",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    )),
              ),
              Form(
                key: _bookingKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter Full Name',
                          labelText: 'Patient Name',
                          //border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      TextField(
                        controller:
                            descController, //editing controller of this TextField
                        decoration: const InputDecoration(
                          icon: Icon(Icons.description), //icon of text field
                          labelText: "Enter Description",
                          hintText: "Enter Description", //label text of field
                        ),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      TextField(
                        controller:
                            dateController, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              dateController.text =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.timelapse_sharp),
                          hintText: 'Enter your time slot',
                          labelText: 'Time',
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeController.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: InkWell(
                  onTap: () async {
                    if (nameController.text != null &&
                        descController.text != null &&
                        dateController.text != null &&
                        timeController.text != null) {
                      Get.snackbar("Oncogems", "Data is processing");
                      print("Application Id: $id");
                      setState(() {
                        loading = true;
                      });

                      Map<String, double> data = {
                        "Patient_name": double.parse(nameController.text),
                        "Description": double.parse(descController.text),
                        "date": double.parse(dateController.text),
                        "time": double.parse(timeController.text),
                      };
                      if (submitChange == 'Submit') {
                        firestore.doc(id).set({
                          "id": id,
                          "Patient_name": nameController.text,
                          "Description": descController.text,
                          "date": dateController.text,
                          "time": timeController.text,
                        }).then((value) {
                          setState(() {
                            loading = false;
                            //submitChange = 'Update';
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => confirmationpage()));
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
            ],
          ),
        ));
  }
}
