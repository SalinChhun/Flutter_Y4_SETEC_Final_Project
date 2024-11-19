import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:ecommerce/views/authentication/Login/LoginUI.dart';
import 'package:flutter/material.dart';

import '../../client/Home.dart';
import '../../client/NavScreen.dart';
import '../../widget/LoadingIcon.dart';
import '../../widget/auth/customlogin.dart';
import 'dart:math';

import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:ecommerce/views/authentication/Register/Register.dart';
import 'package:ecommerce/views/client/Home.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            // TODO: implement listener

            if  (state is LoginCompleted) {

              // Navigator.pop(context);
              print(state.token?.access);
              setLoginTrue(state.token!.user!.id ?? 0,state.token?.access,state.token?.refresh);

              // return Text("${state.token?.refresh}");
              // throw "done";
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                return MyNavScreen();
              },), (route) => false);
            }


            if(state is LoginUnAuthorize) {

              // Future.delayed(Duration(seconds: 5),() => Navigator.pop(context) ,);


             // LoginUI(errormessage: "there is no user associated with please consider register a new account",);

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                PopUpUnauthorize(context);
              });
            }
          },
          builder: (context, state) {

            if(state is LoginLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if(state is LoginError) {



              return Center(child:
                Text("Error has occur due to ${state.error.toString()}")
                ,);
            }

            if(state is LoginError) {



              return Text("Error has occur");
            }
            // if(state is LoginUnAuthorize) {
            //
            //
            //
            //
            //   return LoginUI(errormessage: "there is no user associated with please consider register a new account",);
            // }
            else {

              return LoginUI();
            }

          },
        ),
      ),
    );
  }


  void PopUpUnauthorize(BuildContext context) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Invalid User",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize:22,
            fontWeight: FontWeight.w500,

            color: Color(AppColorConfig.success),
          ),),
        content: Text("Sorry, please we couldn't find any crediential ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w400,

              color: Colors.black
          ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {

                // Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:Color(AppColorConfig.success),
                  elevation: 0,
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black.withOpacity(0.14)),
                      borderRadius: BorderRadius.circular(3)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 10,),
                  Text("Comfirm",style: TextStyle(
                    fontSize: 12.8,

                  ),)
                ],
              ))
        ],
      );
    },);
  }



  void showAlertLoginWrong(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Unauthorize"),
      );
    },);
  }
  void setLoginTrue(int userid,String? tok,String? refresh) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    prefs.setBool("islogin",true);
    print(userid);
    prefs.setInt("userid",userid);
    prefs.setString("token", tok!);
    prefs.setString("refreshtoken", refresh!);
    print(prefs.getBool("islogin"));
  }
}


