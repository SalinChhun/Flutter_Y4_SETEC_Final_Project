
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';


class MyorderScreen extends StatelessWidget {
  const  MyorderScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Center(
          child: Text("Welcome to Order Screen"),
        ),
      ),

    );
  }
}
