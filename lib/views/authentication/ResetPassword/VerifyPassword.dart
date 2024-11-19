import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/Resetpassword/reset_bloc.dart';
import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../client/Home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'VerifyCompleted.dart';

class VerifyPassword extends StatefulWidget {
  var email;

  VerifyPassword({Key? key, this.email}) : super(key: key);

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  var pass;
  var email;
  var txtfirst;
  var txtsec;
  var txtthird;
  var txtfourth;
  var fifth;
  var formkeypassword = GlobalKey<FormState>();
  var iserrorpass = true;
  var istap = true;
  var txtpassword = TextEditingController();
  var showiconpwd = false;

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
      body: BlocListener<ResetBloc, ResetState>(
        listener: (context, state) {
          // TODO: implement listener}

          if(state is ResetPasswordSccess) {

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                      return VerifyCompleted();
                    },), (route) => false);
              });
          }
        },
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 16,),
                  Text("Reset Password", style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,),

                  SizedBox(height: 10,),

                  Text(
                    "Password at least 3 character with uppercase and lowercase 2 char",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.8,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 10,),


                  Container(

                    margin: EdgeInsets.only(top: 25),
                    child: Form(
                      key: formkeypassword,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 13
                        ),
                        cursorColor: Colors.grey,
                        controller: txtpassword,
                        obscureText:
                        istap == false ? istap :

                        true,
                        onFieldSubmitted: (value) {
                          setState(() {
                            txtpassword.text = value;

                            if (formkeypassword.currentState!.validate()) {
                              formkeypassword.currentState!.save();
                            }
                            else {

                            }
                          });
                        },


                        onChanged: (value) {
                          setState(() {
                            // if (formkeypassword.currentState!.validate()) {
                            //
                            //   formkeypassword.currentState!.save();
                            //
                            // }
                            if (value
                                .toString()
                                .length == 0 || value
                                .toString()
                                .isEmpty) {
                              iserrorpass = true;
                            }
                            if (value
                                .toString()
                                .length <= 3) {
                              iserrorpass = true;
                            }


                            else {
                              iserrorpass = false;
                              // setState(() {
                              //   iserrorpass = false;
                              // });
                              return null;
                            }
                            txtpassword.text = value;
                            txtpassword.selection = TextSelection.fromPosition(
                                TextPosition(offset: txtpassword.text.length));
                          });
                        },

                        validator: (value) {
                          if (value
                              .toString()
                              .length == 0 || value
                              .toString()
                              .isEmpty) {
                            iserrorpass = true;
                            return "Password cannot leave blank";
                          }
                          if (value
                              .toString()
                              .length <= 3) {
                            iserrorpass = true;
                            return "Password must be more then 3 char";
                          }


                          else {
                            iserrorpass = false;
                            // setState(() {
                            //   iserrorpass = false;
                            // });
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        onTap: () {
                          setState(() {
                            istap = !istap;
                            showiconpwd = true;
                          });
                        },
                        decoration: InputDecoration(
                            filled: true,

                            suffixIcon:

                            showiconpwd == true
                                ?
                            istap == true ?
                            Icon(Icons.remove_red_eye, color: Colors.grey,) :
                            Icon(Icons.remove_red_eye_outlined,
                              color: Colors.grey,)
                                : null,

                            fillColor: Color(AppColorConfig.bgfill),
                            label: Text("New Password"),
                            floatingLabelStyle: TextStyle(
                                color: Colors.black
                            ),

                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),

                      ),
                    ),
                  ),

                  SizedBox(height: 36,),

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

                              if(iserrorpass == true) {
                                showDialog(context: context, builder: (context) {


                                  return  Center(

                                    child: CircularProgressIndicator(
                                      color: Color(AppColorConfig.bgcolor),

                                    ),
                                  );

                                },);
                               Future.delayed(Duration(seconds: 2),() => Navigator.pop(context),);
                                return;
                              }
                              showDialog(context: context, builder: (context) {


                                return  Center(

                                  child: CircularProgressIndicator(
                                    color: Color(AppColorConfig.bgcolor),

                                  ),
                                );

                              },);
                              context.read<ResetBloc>().add(SendResetPassword(widget.email, txtpassword.text));

                            }, child: Text("Done")),
                      ),
                    ],
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }

  void getemailandpass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    pass = prefs.getString("pass");
  }

  void Verifycomplete(token, userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('userid', userid);
    print(prefs.getString('token'));
    email = prefs.getString("email");
    pass = prefs.getString("pass");
  }
}
