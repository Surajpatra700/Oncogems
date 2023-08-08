import 'package:achiever/screens/plants_Screens/plantScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff61B688).withOpacity(0.7),
            Color(0xff61B688).withOpacity(0.5),
            Color(0xff61B688).withOpacity(0.4),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
          stops: [0.0, 0.5, 1.0],
          tileMode: TileMode.clamp
          ),
        ),
        child: PlantScreen(),
      ),
    );
  }
}