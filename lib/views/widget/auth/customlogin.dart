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

import '../../../viewmodel/validator/form_bloc.dart';
import '../../authentication/ResetPassword/ResetPassword.dart';
import '../../client/NavScreen.dart';

class LoginForm extends StatefulWidget {
  var error;

  LoginForm({
    super.key,
    this.error
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}


class _LoginFormState extends State<LoginForm> {
  var istap = true;
  var showiconpwd = true ;

  var txtemail = TextEditingController();
  var txtpassword = TextEditingController();
  var formkeyemail = GlobalKey<FormState>();
  var formkeypassword = GlobalKey<FormState>();
  var iserror = false;
  AuthService auth = AuthService();
  LoginBloc login = LoginBloc();

  var iserroremail = true;

  var iserrorpass = true;
  var googleemail = null;

  @override
  void initState() {
    // TODO: implement initState
    setEmailUser();
    super.initState();

  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Welcome back! Glad to see you again",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,),
              ),
              SizedBox(width: 50,)
            ],
          ),
          SizedBox(height: 10,),
          if(widget.error != null )
            Text(widget.error, style: TextStyle(
                color: Colors.red,
                fontSize: 12.8
            ),),

          Container(

            margin: EdgeInsets.only(top: 25),
            child: Container(

              child: Form(
                key: formkeyemail,
                child: TextFormField(
                  validator: (value) {
                    final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (value
                        .toString()
                        .length == 0 || value
                        .toString()
                        .isEmpty) {
                      iserroremail = true;
                      return "Email cannot leave blank";
                    }
                    if (!reg.hasMatch(value.toString())) {
                      iserroremail = true;
                      return "Please provide a valid email address";
                    }

                    else {
                        iserroremail = false;
                      // setState(() {
                      //   iserroremail = false;
                      // });

                      return null;
                    }
                  },
                  style: TextStyle(

                      fontSize: 13
                  ),
                  controller: txtemail,
                  keyboardType: TextInputType.emailAddress,
                  // onSaved: (newValue) {
                  //   setState(() {
                  //     txtemail.text = newValue.toString();
                  //     if (formkeyemail.currentState!.validate()) {
                  //       formkeyemail.currentState!.save();
                  //
                  //     }
                  //     else {
                  //
                  //     }
                  //   });
                  // },
                  onFieldSubmitted: (value) {
                    setState(() {
                      txtemail.text = value;
                      if (formkeyemail.currentState!.validate()) {
                        formkeyemail.currentState!.save();

                      }
                      else {

                      }
                      istap = true;
                      showiconpwd = true;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (value
                          .toString()
                          .length == 0 || value
                          .toString()
                          .isEmpty) {
                        iserroremail = true;

                      }
                      if (!reg.hasMatch(value.toString())) {
                        iserroremail = true;

                      }

                      else {
                        iserroremail = false;
                        // setState(() {
                        //   iserroremail = false;
                        // });

                        return null;
                      }
                      txtemail.text = value;
                      txtemail.selection = TextSelection.fromPosition(TextPosition(offset: txtemail.text.length));
                    });



                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,



                  onTap: () {

                  },
                  cursorColor: Colors.grey,
                  textInputAction: TextInputAction.next,

                  decoration: InputDecoration(


                      filled: true,

                      suffixIcon: InkWell(
                        onTap: () => txtemail.clear(),
                        child: Icon(Icons.clear),
                      ),

                      suffixStyle: TextStyle(
                        color: Colors.red
                      ),




                      fillColor: Color(AppColorConfig.bgfill),

                      label: Text("Email"),

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
          ),
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
                istap ,
                onFieldSubmitted: (value) {
                  setState(() {
                    txtpassword.text = value;

                    if (formkeypassword.currentState!.validate()) {

                      formkeypassword.currentState!.save();

                    }
                    else{

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
                    if(value.toString().length <=3 ) {
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
                    txtpassword.selection = TextSelection.fromPosition(TextPosition(offset: txtpassword.text.length));





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
                  if(value.toString().length <=3 ) {
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


                  });
                },
                decoration: InputDecoration(
                    filled: true,

                    suffixIcon:

                    showiconpwd == false  ?
                    InkWell(
                        onTap: () {
                          setState(() {
                            showiconpwd = true;
                            istap= true  ;
                          });

                        },
                        child: Icon(Icons.remove_red_eye, color: Colors.black,)) :
                    InkWell(
                        onTap: () {
                          setState(() {
                            showiconpwd = false ;
                            istap= false ;
                          });

                        },
                        child: Icon(Icons.remove_red_eye_outlined, color: Colors.grey,)),


                    fillColor: Color(AppColorConfig.bgfill),
                    label: Text("Password"),
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
          //TODO forget password
          SizedBox(height: 15,),
          InkWell(
              onTap: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance() ;

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ResetPassword(
                    email: prefs.getString('email'),


                  );
                },));
              },


              child: Text('forget password?', textAlign: TextAlign.right,)),

          Container(

            margin: EdgeInsets.only(top: 15, bottom: 15),
            width: double.maxFinite,
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: Color(AppColorConfig.primarycolor),
                padding: EdgeInsets.all(10),

              ),
              onPressed: () async {
                // login.add(LoginUser(txtemail.text, txtpassword.text));
                print(iserroremail);
                print(iserrorpass);

                if (formkeypassword.currentState!.validate()) {

                  formkeypassword.currentState!.save();

                }
                if (formkeyemail.currentState!.validate()) {

                  formkeyemail.currentState!.save();

                }

                if(iserroremail == true || iserrorpass == true) {
                  print("Either email or pass is null");

                  BlocProvider.of<FormBloc>(context).add(CheckValidateevent(
                      iserroremail: iserroremail, iserrorpass: iserrorpass));
                  return;
                }
                showDialog(context: context, builder: (context) {


                  return  Center(

                    child: CircularProgressIndicator(
                      color: Color(AppColorConfig.bgcolor),

                    ),
                  );

                },);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('email', txtemail.text);

                BlocProvider.of<LoginBloc>(context).add(
                    LoginUser(txtemail.text, txtpassword.text));
              }, child: BlocConsumer<FormBloc,FormStateAD>(
              listener: (context, state) {
                // TODO: implement listener
                print(state);

              if(state is FormLoading) {
                showDialog(context: context, builder: (context) {


                  return  Center(

                    child: CircularProgressIndicator(
                      color: Color(AppColorConfig.bgcolor),

                    ),
                  );

                },);
                Future.delayed(Duration(seconds: 2),() => Navigator.pop(context) ,);
              }
              if(state is FormError) {
                print("True");
                // showDialog(context: context, builder: (context) {
                //
                //
                //   return  Center(
                //
                //     child: CircularProgressIndicator(
                //       color: Color(AppColorConfig.bgcolor),
                //
                //     ),
                //   );
                //
                // },);
                // Future.delayed(Duration(seconds: 2),() => Navigator.pop(context) ,);
              }


              },
              builder: (context, state) {

                if(state is FormLoading) {
                  return Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(


                      color: Colors.white,
                      backgroundColor: Colors.black,

                    ),
                  );
                }
                if(state is FormError){
                  return Text("Login",
                    textAlign: TextAlign.center,
                    style:
                    Theme
                        .of(context)
                        .textTheme
                        .displaySmall,);
                }
                else {
                  return Text("Login",
                    textAlign: TextAlign.center,
                    style:
                    Theme
                        .of(context)
                        .textTheme
                        .displaySmall,);
                }

              },
            ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  height: 1,

                ),
              ),
              SizedBox(width: 10,),
              Text("Continue with", style: TextStyle(
                  fontSize: 12.8,
                  color: Colors.grey
              ),),
              SizedBox(width: 10,),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  height: 1,

                ),
              ),
            ],
          ),
          SizedBox(height: 10,),

          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 1,
            margin: EdgeInsets.only(bottom: 20),


            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        var googleemail = await auth.signInWithGoogle();
                        print("Google email is ${googleemail}");

                        if(googleemail["email"] == null ) {
                         print("User Cancel");
                        }
                        else {
                          context.read<LoginBloc>().add(LoginSocialAuth(googleemail["email"]));
                          print("Login google is sent");
                        }

                      }catch(error) {
                        print(error);
                      }


                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Color(AppColorConfig.bgcolor)
                          .withOpacity(0.85),
                      padding: EdgeInsets.all(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo/Google.png'),
                        SizedBox(width: 10,),
                        Text("Google", style: TextStyle(
                            fontSize: 12.7,
                            color: Colors.grey
                        ),)
                      ],),


                  ),
                ),
                SizedBox(width: 10,),


                Expanded(
                  child: ElevatedButton.icon(


                    label: Text(" Continue as guest",

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.8
                      ),
                    ),
                    icon: Icon(Icons.person),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.all(10),

                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                          return MyNavScreen();
                        },), (route) {
                          return false;
                        },);
                    },
                  ),
                ),


              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
                  return RegisterScreen();
                },), (route) {
                  return false;
                },);
            },
            child: Container(

              alignment: Alignment.center,
              child: Text('New member here? Sign Up Now',
                style: TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),

                textAlign: TextAlign.center,
              ),
            ),
          ),

        ],
      ),
    );
  }

  void setLoginTrue() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    prefs.setBool("islogin", true);
    print(prefs.getBool("islogin"));
  }

  void setEmailUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    txtemail.text = prefs?.getString('email') ?? '';

  }
}