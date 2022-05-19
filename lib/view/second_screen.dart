import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/const.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? username;

  getUserName() {
    final obtainedName = box.read('username');
    setState(() {
      username = obtainedName;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome $username",
            textScaleFactor: 3,
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Go Back"),
          )
        ],
      )),
    );
  }
}
