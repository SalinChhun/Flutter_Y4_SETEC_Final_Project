
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/material.dart';

import '../client/Home.dart';
import 'Login/LoginScreen.dart';
import 'Register/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequireLoginandSignup extends StatefulWidget {
  const RequireLoginandSignup({Key? key}) : super(key: key);

  @override

  State<RequireLoginandSignup> createState() => _RequireLoginandSignupState();
}

class _RequireLoginandSignupState extends State<RequireLoginandSignup> {
  SharedPreferences? prefs ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Column(
         crossAxisAlignment:CrossAxisAlignment.center ,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          mainAxisSize: MainAxisSize.max,
          children: [
            //TODO image here
              Expanded(


                  child:

              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black
                ),

                child: Image.asset('assets/images/sneaker.png',
                  color: Colors.black45,

                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,



                ),
              )),
            SizedBox(height: 14,),

            //TODO button here
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),

              child: Column(children: [
                  Container(
                    child: ElevatedButton(onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                          return  loginScreen ();
                        },), (route) {
                          return false;
                        },);

                    }, child:Text("Login",style: Theme.of(context).textTheme.displaySmall,),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                          padding: EdgeInsets.all(8),
                        backgroundColor: Color(AppColorConfig.primarycolor)
                      ),

                    ),
                    width: double.maxFinite,
                  ),
                SizedBox(height: 2,),
                 Container(

                  child: ElevatedButton(

                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                          return   RegisterScreen ();
                        },), (route) {
                          return false;
                        },);
                  }, child:Text("Sign Up",style:TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),),
                    style: ElevatedButton.styleFrom(

                        elevation: 0,
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(

                            color: Colors.grey.withOpacity(0.46),



                          )
                        ),
                        backgroundColor: Color(AppColorConfig.bgcolor)
                    ),

                  ),
                  width: double.maxFinite,
                ),
                SizedBox(height: 10,),
                TextButton(onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                      return MyNavScreen();
                    },), (route) {
                      return false;
                    },);

                }, child: Text("Continue as guest",style: TextStyle(
                    fontSize: 12.8,
                    color: Colors.black,
                  fontWeight: FontWeight.w400
                ),))
              ],),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
