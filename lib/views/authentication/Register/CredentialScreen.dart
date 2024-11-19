
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/authlogin/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../widget/LoadingIcon.dart';
import 'CredentialScreen.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'VerifyScreen.dart';



class CredentialScreen extends StatefulWidget {
   var isowner ;
   var username;
   var lastname;
   var firstname;
   var tele;
   var gender;
   CredentialScreen ({Key? key,this.isowner,this.username,this.lastname,this.firstname,this.tele,this.gender}) : super(key: key);

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  var txtemail = TextEditingController();
  var txtpassword = TextEditingController();
  var istap = true;
  var formkeyemail = GlobalKey<FormState>();
  var formkeypassword = GlobalKey<FormState>();
  var iserror = false;
  var iserroremail = true;
  var showiconpwd = false;
  var iserrorpass = true;
  var googleemail = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.isowner);
    print(widget.firstname);
    print(widget.lastname);
    print(widget.username);
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BlocConsumer<RegisterBloc,RegisterState>(
  listener: (context, state) {
    // TODO: implement listener
    print(state);
    if(state is Registerloading) {
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
      // Future.delayed(Duration(seconds: 2), () => Navigator.pop(context),);


    }
    if(state is RegisterDuplicate) {
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
      // Future.delayed(Duration(seconds: 2), () => Navigator.pop(context),);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        PopUpUnauthorize(context);
      });
    }
  },
  builder: (context, state) {

    if(state is RegisterError) {
     print("Email already exist");
    }
    if(state is RegisterCompleted) {
      Navigator.pop(context);
      storeemailandpass(txtemail.text,txtpassword.text);


      return VerifyScreen();

    }

    else{
      return SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO image phone here
            Center(
              child: Lottie.asset("assets/lotties/lock.json",
                  fit: BoxFit.cover,

                  width:double.maxFinite
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Credential",style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: 10,),
                  Text("Please enter your credential email and password for login to our application",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  //TODO form here

                  //TODO select country
                  SizedBox(height: 25,),
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
                              return "Email cannot leave blank";
                            }
                            if (!reg.hasMatch(value.toString())) {
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
                            setState(() {
                              istap = false;
                              showiconpwd = false;
                            });
                          },
                          cursorColor: Colors.grey,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              filled: true,


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
                        istap == false ? istap :

                        true,
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
                            return "Password cannot leave blank";
                          }
                          if(value.toString().length <=3 ) {
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
                            Icon(Icons.remove_red_eye_outlined, color: Colors.grey,)
                                : null,

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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 1,bottom: 15,left: 15,right: 15),
              width: double.maxFinite,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color(AppColorConfig.primarycolor),
                  padding: EdgeInsets.all(10),

                ),
                onPressed: () async{
                  // await Future.delayed(Duration(
                  //   seconds: 2
                  // ));

                  if (formkeypassword.currentState!.validate()) {

                    formkeypassword.currentState!.save();

                  }
                  if (formkeyemail.currentState!.validate()) {

                    formkeyemail.currentState!.save();

                  }
                  if(iserroremail == true || iserrorpass == true  ) {
                    print("Error is happening");
                    showDialog(context: context, builder: (context) {


                      return  Center(

                        child: CircularProgressIndicator(
                          color: Color(AppColorConfig.bgcolor),

                        ),
                      );

                    },);
                    Future.delayed(Duration(seconds: 2), () => Navigator.pop(context),);
                    return;
                  }


                  BlocProvider.of<RegisterBloc>(context,listen: false).add(OnRegister(
                      widget.firstname, widget.lastname,
                      txtemail.text, txtpassword.text, widget.tele, widget.username,widget.gender));

                  // Navigator.pushAndRemoveUntil(context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return VerifyScreen();
                  //   },), (route) {
                  //   return false;
                  // },);


                }, child:Text("Sign In",
                textAlign: TextAlign.center,
                style:
                Theme.of(context).textTheme.displaySmall,),
              ),
            ),





            //TODO register Phone num here
          ],
        ),
      );
    }

  },
);
            },

          )
      ),
    );
  }
  void PopUpUnauthorize(BuildContext context) {
  Navigator.pop(context);
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Email Duplicate",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize:22,
            fontWeight: FontWeight.w500,

            color: Color(AppColorConfig.success),
          ),),
        content: Text("Sorry, an email has already registered, please try another one",
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
  void storeemailandpass(email,pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email",email);
    prefs.setString("pass", pass);
  }
}
