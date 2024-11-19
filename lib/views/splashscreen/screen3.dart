
import 'package:lottie/lottie.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatelessWidget {
  var apptitle;
  GettingStarted  ({this.apptitle });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        height: 430,
        child: Lottie.asset('assets/lotties/animation_lmr6sqpi.json',


            fit: BoxFit.contain
        ),
        decoration: BoxDecoration(
            // color: Colors.blue
        ),
      ),
    );
  }


}