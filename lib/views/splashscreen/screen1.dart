


import 'package:ecommerce/views/splashscreen/screen2.dart';
import 'package:ecommerce/views/splashscreen/screen3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  var apptitle;
 WelcomeScreen ({this.apptitle });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var _pagecontroller = PageController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.maxFinite,
        height: 430,
        child: Lottie.asset('assets/lotties/animation_lmr6ox6u.json',


        fit: BoxFit.contain
        ),
        decoration: BoxDecoration(
            // color: Colors.green
        ),
      ),
    );
  }
}