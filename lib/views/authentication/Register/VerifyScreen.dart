import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/authlogin/login_bloc.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../client/Home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/LoadingIcon.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  var pass;
  var email;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            print(state);

            if(state is LoginLoading) {
              showDialog(context: context, builder: (context) {


                return  Center(

                  child: CircularProgressIndicator(
                    color: Color(AppColorConfig.bgcolor),

                  ),
                );

              },);
              // Future.delayed(Duration(seconds: 2), () => Navigator.pop(context),);

            }

            if(state is LoginUnAuthorize) {

              Future.delayed(Duration(seconds: 2), () => Navigator.pop(context),);
            }
            if(state is LoginCompleted) {
              // Verifycomplete(state.token?.access,state.token?.user?.id);
            }
          },

          builder: (context, state) {

              if(state is LoginLoading){
                return Text('');
              }
              if(state is LoginError){
                return Center(
                  child: Text("Error has been occur"),
                );
              }
              if(state is LoginCompleted){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

                  Verifycomplete(state.token?.access,state.token?.user?.id);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                    return MyNavScreen(uid: state.token?.user?.id,
                      login: true,
                      token: state.token?.access,
                    );
                  },), (route) => false);


                });
                return Text("");

              }
              else{
                return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Verify Your Account", style: TextStyle(
                        fontSize: 27,
                       fontWeight: FontWeight.w600,
                       color: Color(AppColorConfig.success),
                      ),),
                      SizedBox(height: 20,),
                      Text(
                        "An email related to your account has been sent check email to verify "
                            "and after you have done , please click the comfirm"
                            "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(AppColorConfig.success),
                            fontSize: 12.8,

                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Lottie.asset('assets/lotties/emal_icon_2.json'),
                      SizedBox(height: 25,),
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton.icon(
                          onLongPress: () {


                          },

                          label: Text("Continue",

                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.8,
                              color: Color(AppColorConfig.primarylight)
                            ),
                          ),
                          icon: Icon(Icons.lock,
                         color: Color(AppColorConfig.primarylight),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)
                            ),
                            elevation: 0,
                            backgroundColor: Color(AppColorConfig.success),
                            padding: EdgeInsets.all(10),

                          ),
                          onPressed: () async {
                            print(email);
                            print(pass);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("email", email);
                            prefs.setBool("islogin", true);
                            BlocProvider.of<LoginBloc>(context,listen: false).add(LoginUser(email, pass));
                            // Navigator.pushAndRemoveUntil(context,
                            //   MaterialPageRoute(builder: (context) {
                            //     return MyNavScreen();
                            //   },), (route) {
                            //     return false;
                            //   },);
                          },
                        ),
                      ),

                    ],
                  ),
                );
              }


            }


        ),
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
    print("User token is ${prefs.getString('token')}");
    print(prefs.getString('token'));
    email = prefs.getString("email");
    pass = prefs.getString("pass");
    prefs.setString('email', email);

  }
}
