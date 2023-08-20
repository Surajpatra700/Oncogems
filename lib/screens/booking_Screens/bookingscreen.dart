// ignore_for_file: prefer_const_constructors, unused_import, avoid_unnecessary_containers

import 'package:achiever/screens/achievement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/toast.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final searchController = TextEditingController();
  String search = "";
  final databaseRef =
      FirebaseFirestore.instance.collection("Doctor").snapshots();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // CollectionReference users = FirebaseFirestore.instance.collection('/Doctor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Center(
            child: Container(
                child: Column(children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 280,
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(colors: [
                      //   Color.fromARGB(255, 52, 62, 119),
                      //   Color.fromARGB(255, 10, 16, 45),
                      // ]),
                      image: DecorationImage(
                          image: AssetImage("assets/images/doctorpatient.jpg"),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12, right: 12, top: 240),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Search for proffession",
                          suffixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)),
                        ),
                        onChanged: (String value) {
                          print(value);
                          setState(() {
                            search = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Text(
                "Doctors List",
                style: TextStyle(
                    color: Color.fromARGB(255, 8, 26, 40),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 25),
              // Column(
              //   children: [
                StreamBuilder<QuerySnapshot>(
                    stream: databaseRef,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                late String domain =
                                    snapshot.data!.docs[index]['proffession'].toString();
                                if (searchController.text.isEmpty) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Card(
                                          elevation: 2.5,
                                          child: ListTile(
                                            onTap: () async {
                                              final Uri url = Uri(
                                                scheme: "tel",
                                                path: snapshot.data?.docs[index]
                                                    ['contactnumber'],
                                              );
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url);
                                              } else {
                                                Utils(check: false).toastMessage(
                                                    "Sorry can't launch this url",
                                                    true);
                                              }
                                            },
                                            tileColor: Colors.white,
                                            leading: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data?.docs[index]
                                                            ['photourl']),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            title: Center(
                                                child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['proffession'],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "(${snapshot.data?.docs[index]['work_experience']}+ yrs of experience)",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13.5,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['proffession'],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            )),
                                            subtitle: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 65.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(
                                                      snapshot.data?.docs[index]
                                                          ['contactnumber'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (domain.toLowerCase().contains(
                                    searchController.text.toLowerCase())) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Card(
                                          elevation: 2.5,
                                          child: ListTile(
                                            onTap: () async {
                                              final Uri url = Uri(
                                                scheme: "tel",
                                                path: snapshot.data?.docs[index]
                                                    ['contactnumber'],
                                              );
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url);
                                              } else {
                                                Utils(check: false).toastMessage(
                                                    "Sorry can't launch this url",
                                                    false);
                                              }
                                            },
                                            tileColor: Colors.white,
                                            leading: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data?.docs[index]
                                                            ['photourl']),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            title: Center(
                                                child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      color: Colors.deepPurple,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  snapshot.data?.docs[index]
                                                      ['proffession'],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "(${snapshot.data?.docs[index]['work_experience']}+ yrs of experience)",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13.5,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "",
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: domain,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                // Text(
                                                //   domain,
                                                //   style: TextStyle(
                                                //       color: Colors.black54,
                                                //       fontSize: 14,
                                                //       fontWeight: FontWeight.w400),
                                                // ),
                                              ],
                                            )),
                                            subtitle: Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 65.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(
                                                      snapshot.data?.docs[index]
                                                          ['contactnumber'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }));
                    }),
              //])
            ]))));
  }
}
