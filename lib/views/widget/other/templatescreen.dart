
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';


class Some extends StatelessWidget {
  const Some({Key? key, required username, required lastname, required firstname, required bool isowner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Center(
          child: Text("Some Screen"),
        ),
      ),
    );
  }
}
