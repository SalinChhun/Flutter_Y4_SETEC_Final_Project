import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/authlogin/register_bloc.dart';
import 'package:ecommerce/views/authentication/Register/VerifyScreen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:flutter/material.dart';

import '../../client/Home.dart';
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
import '../../widget/auth/customlogin.dart';
import '../../widget/auth/customregister.dart';
import 'package:bloc/bloc.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();


}

class _RegisterScreenState extends State<RegisterScreen> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            // TODO: implement listener
            print(state);
            if(state is Registerloading) {
              print("Loading here");
              showDialog(context: context, builder: (context) {


                return  Center(

                  child: CircularProgressIndicator(
                    color: Color(AppColorConfig.bgcolor),

                  ),
                );

              },);
            }

            else if(state is RegisterValidateError) {
              showDialog(context: context, builder: (context) {


                return  Center(

                  child: CircularProgressIndicator(
                    color: Color(AppColorConfig.bgcolor),

                  ),
                );

              },);
              Future.delayed(Duration(seconds: 2),() =>     context.read<RegisterBloc>().add(RegisterClearState()),);

            }

          },
          builder: (context, state) {
            if(state is Registerloading) {
              return LoadingIcon();
            }
            if(state is RegisterError) {
              return Center(child: Text("Error has occur"),);
            }
            if(state is RegisterCompleted) {
              return VerifyScreen();
            }
            else{
              return SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,


                  children: [
                    //TODO image
                    Container(
                      child: Image.asset('assets/images/unsplash_D4jRahaUaIc.png',
                        width: double.maxFinite,
                        height: 200,
                        color: Colors.black12,


                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken,


                      ),
                    ),


                   Container(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      margin: EdgeInsets.only(bottom: 30),

                      child: RegisterForm(),
                    ),


                    //TODO login part here


                  ],
                ),
              );
            }

          },
        ),
      ),
    );
  }
}
