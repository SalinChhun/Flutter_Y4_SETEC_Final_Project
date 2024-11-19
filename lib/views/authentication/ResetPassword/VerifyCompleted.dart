import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:ecommerce/views/authentication/Require.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../client/Home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCompleted extends StatefulWidget {
  VerifyCompleted({Key? key}) : super(key: key);

  @override
  State<VerifyCompleted> createState() => _VerifyCompletedState();
}

class _VerifyCompletedState extends State<VerifyCompleted> {
  var pass;
  var email;
  var txtfirst;
  var txtsec;
  var txtthird;
  var txtfourth;
  var fifth;
  var txtpassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getemailandpass();
    super.initState();
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/logo/success.json'),
                // Icon(Icons.check,size: 60,color: Color(AppColorConfig.success),),
                SizedBox(height: 16,),
                Text("Verified", style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,),

                SizedBox(height: 26,),

                Text(
                  "Your Password has been reset successfully!!! ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.8,
                  ),
                  textAlign: TextAlign.center,
                ),


                SizedBox(height: 26,),

                Row(

                  children: [
                    Expanded(

                      child:
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(12),
                              backgroundColor: Color(AppColorConfig.success)
                          ),
                          onPressed: () {
    Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) {
    return RequireLoginandSignup();
    },), (route) => false);

                          }, child: Text("Done")),
                    ),
                  ],
                ),



              ],
            ),
          )
      ),
    );
  }

  void getemailandpass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    pass = prefs.getString("pass");
  }
  void Verifycomplete(token,userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('userid', userid);
    print(prefs.getString('token'));
    email = prefs.getString("email");
    pass = prefs.getString("pass");

  }
}
