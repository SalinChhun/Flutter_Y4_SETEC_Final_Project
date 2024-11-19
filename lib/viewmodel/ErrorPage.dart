


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class PageError extends StatelessWidget {

  var image;
  var errormessage;
  var lottieimage;
   PageError({Key? key,this.image,this.errormessage,this.lottieimage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(lottieimage,fit: BoxFit.cover),
      ),
    );
  }
}
