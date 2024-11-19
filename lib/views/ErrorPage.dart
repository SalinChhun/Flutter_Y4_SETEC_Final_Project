


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {

  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: null,
      body: SafeArea(child: Center(
        child:
        Padding(
          padding: EdgeInsets.all(28.0),
          child: Text('There may has been connection error , please restart your app'),
        ),
      )),
    );
  }
}
