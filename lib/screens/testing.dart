import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TextButton(
        onPressed: () => throw Exception(),
        child: Text("Throw Test Exception"),
      ),
    );
  }
}
