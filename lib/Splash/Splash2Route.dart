import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../Navigator/BottomBar.dart';

class Splash2Route{

  void isLogin(BuildContext context){
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBar()));

    });
  }
}