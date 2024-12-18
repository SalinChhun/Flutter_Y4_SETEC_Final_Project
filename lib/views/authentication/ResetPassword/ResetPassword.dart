import 'dart:async';

import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/Resetpassword/reset_bloc.dart';
import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../client/Home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'VerifyCompleted.dart';
import 'VerifyPassword.dart';

class ResetPassword extends StatefulWidget {
  var email;
  ResetPassword({Key? key,this.email}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var pass;
  var email;
  var txtfirst = TextEditingController();
  var txtsec= TextEditingController();
  var txtthird= TextEditingController();
  var txtfourth= TextEditingController();
  var alwaysfocus = FocusNode();
  var fifth= TextEditingController();
  var fnodeone = FocusNode();
  var fnodetwo = FocusNode();
  var fnodethr = FocusNode();
  var fnodefou = FocusNode();
  var fnodefif = FocusNode();


  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  @override
  void initState() {
    // TODO: implement initState
    getemailandpass();
    errorController.add(ErrorAnimationType.shake); // This will shake the pin code field

    context.read<ResetBloc>().add(SendCode(email: widget.email));
    alwaysfocus.requestFocus();
    super.initState();
  }
  @override
  void dispose() {
    errorController.close();

    // TODO: implement dispose
    super.dispose();
  }
  void PopUpUnauthorize(BuildContext context) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Wrong Code",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize:22,
            fontWeight: FontWeight.w500,

            color: Color(AppColorConfig.success),
        ),),
        content: Text("Sorry, please check your verification code again ",
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(28.0),
      child: BlocListener<ResetBloc, ResetState>(
  listener: (context, state) {
    // TODO: implement listener}
    print(state);

    if(state is VerifyCodeAuthorize) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(seconds: 2),() => Navigator.pop(context) ,);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
         return VerifyPassword(email: widget.email,);
        },), (route) => false);
      });



    }

    if(state is UnAuthorizeCode){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(seconds: 2),() => Navigator.pop(context) ,);

        PopUpUnauthorize(context);

      });
    }

    if(state is ResetVerifyCodeSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // Future.delayed(Duration(seconds: 1),() => Navigator.pop(context) ,);

      });
    }
    if(state is ResendCodeSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(seconds: 1),() => Navigator.pop(context) ,);

      });
    }
  },
  child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email,size: 60,color: Color(AppColorConfig.success),),
            SizedBox(height: 16,),

            Text("Verification Code?", style: Theme
                .of(context)
                .textTheme
                .headlineLarge,),

            SizedBox(height: 10,),

            Text(
              "An verfication code has sent to your email related to your account ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.8,
              ),
              textAlign: TextAlign.center,
            ),


            SizedBox(height: 16,),
            PinCodeTextField(
              length: 5,
              obscureText: false,
              pinTheme: PinTheme(
                activeColor: Color(AppColorConfig.primarycolor),
                activeFillColor: Colors.grey,
                selectedFillColor: Colors.grey,
                inactiveColor: Colors.red,
                inactiveFillColor:Colors.red,
                selectedColor: Colors.red

              ),
              animationType: AnimationType.fade,
               textStyle: TextStyle(
                 color: Color(AppColorConfig.success)
               ),
              keyboardType: TextInputType.number,


              animationDuration: Duration(milliseconds: 300),

              errorAnimationController: errorController, // Pass it here
              onChanged: (value) {
                setState(() {
                  txtfirst.text = value;

                  print(  txtfirst.text);
                });
              }, appContext: context,
            ),
            SizedBox(height: 16,),
            Row(

              children: [
                Expanded(

                  child:
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                          padding: EdgeInsets.all(12),
                backgroundColor: Color(AppColorConfig.primarycolor)
            ),
                      onPressed: () {
                        showDialog(context: context, builder: (context) {


                          return  Center(

                            child: CircularProgressIndicator(
                              color: Color(AppColorConfig.bgcolor),

                            ),
                          );

                        },);
                        var code = txtfirst.text+txtsec.text+txtthird.text+txtfourth.text+fifth.text;
                        print(code);




                        context.read<ResetBloc>().add(SendVerifyCode(

                            email: widget.email,
                            code:txtfirst.text
                        ));


                  }, child: Text("Done", style: TextStyle(color: Colors.white),)),
                ),
              ],
            ),
            SizedBox(height: 40,),
            InkWell(
              onTap: () {
                print("Resend code");
                showDialog(context: context, builder: (context) {


                  return  Center(

                    child: CircularProgressIndicator(
                      color: Color(AppColorConfig.bgcolor),

                    ),
                  );

                },);
                context.read<ResetBloc>().add(ResendVerifyCode(

                    email: widget.email

                ));

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Resend Code ",
                    style: TextStyle(
                      color: Color(AppColorConfig.primarycolor),
                      fontSize: 12.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
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
