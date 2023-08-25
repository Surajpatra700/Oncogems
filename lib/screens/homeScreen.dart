// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:achiever/screens/achievement.dart';
import 'package:achiever/screens/homePage.dart';
import 'package:achiever/screens/profile.dart';
import 'package:achiever/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:local_auth/local_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  PageController pageController = PageController();
  bool authenticatedUser = false;
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void _openDrawer() {
  //   _scaffoldKey.currentState!.openDrawer();
  // }

  List screens = [
    HomePage(),
    AchievementScreen(),
    ProfileScreen(),
  ];

  Widget buildAppBar() {
    return AppBar(
      elevation: 2.5,
      backgroundColor: Color(0xff50a387),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Row(
          children: [
            // IconButton(icon: Icon(Icons.menu),onPressed: (){
            //   _openDrawer();
            // },),
            Text(
              "Oncogems",
              style: TextStyle(
                  fontSize: 24.5.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              
            },
            icon: Icon(
              Icons.menu,
              size: 28,
            )),
      ],
    );
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Unlock Oncogems',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      if (!authenticated) {
        // Authentication successful, set a flag in SharedPreferences
        Get.defaultDialog(
          backgroundColor: Colors.grey.shade200,
          title: "Oncogems", titleStyle: TextStyle(fontWeight: FontWeight.w700),
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          middleText:
              "Please Enter your FingerPrint or Pattern Lock !", // middle text doesn't allow more than 3 lines of text therefore we use content.
          confirm: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff50a387)),
              onPressed: () {
                authenticatedUser? Get.back() : _authenticate();
              },
              child: Text("Ok")),
        );
      } else {
        setState(() {
          authenticatedUser = true;
        });
      }
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  late final LocalAuthentication auth;
  bool _supportState = false;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState = isSupported;
      });
      _authenticate();
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 680),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(63.h), child: buildAppBar()),
          // Drawer
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Add functionality for the first drawer item here
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Add functionality for the second drawer item here
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                // Add more ListTile widgets for additional items
              ],
            ),
          ),
          body: PageView.builder(
              itemCount: 3,
              controller: pageController,
              onPageChanged: (page) {
                setState(() {
                  _index = page;
                });
              },
              itemBuilder: (context, position) {
                return Container(
                  child: screens[position],
                );
              }),
          bottomNavigationBar: SafeArea(
            child: Container(
              color: Color(0xff50a387),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: GNav(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 250),
                  backgroundColor: Color(0xff50a387),
                  tabBackgroundColor: Color.fromARGB(255, 72, 201, 76),
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  activeColor: Colors.white,
                  gap: 8,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      iconActiveColor: Colors.white,
                      iconColor: Colors.white70,
                    ),
                    GButton(
                      icon: Icons.book,
                      text: 'Consultancy',
                      iconActiveColor: Colors.white,
                      iconColor: Colors.white70,
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                      iconActiveColor: Colors.white,
                      iconColor: Colors.white70,
                    ),
                  ],
                  selectedIndex: _index,
                  onTabChange: (index) {
                    setState(() {
                      _index = index;
                    });
                    pageController.jumpToPage(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   void _openDrawer() {
//     _scaffoldKey.currentState!.openDrawer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('Drawer Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _openDrawer,
//           child: Text('Open Drawer'),
//         ),
//       ),

//     );
//   }
// }
