import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_space2/login.dart';

class NewSpace extends StatefulWidget {
  const NewSpace({Key? key}) : super(key: key);

  @override
  State<NewSpace> createState() => _NewSpaceState();
}

class _NewSpaceState extends State<NewSpace> {
  @override
  void initState() {
    Timer(Duration(seconds: 1),(){
      Get.offAll(Login());
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Image.asset('assets/image/bodyLanguage.png', fit: BoxFit.cover,),
          ),
          CircularProgressIndicator()
        ],
      )
    );
  }
}
