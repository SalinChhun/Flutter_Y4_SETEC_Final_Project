import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/Token/token_bloc.dart';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewmodel/ErrorPage.dart';
import '../../authentication/Require.dart';
import '../../splashscreen/starter.dart';
import '../NavScreen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    // context.read<TokenBloc>().add(VerifyTokenUser());
    setPreference();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body:

      BlocListener<TokenBloc, TokenState>(
        listener: (context, state) {
          // TODO: implement listener}
          print("The current use event is");
          print(state);
          // Future.delayed(Duration(seconds: 2),() {
          //   print("Done");
          // },);
          if (state is TokenUnauthorize) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) {
                return RequireLoginandSignup();
              },), (route) => false);
            });
          }
          if (state is TokenVerify) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) {
                return MyNavScreen();
              },), (route) => false);
            });
          }
          if (state is TokenError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) {
                return PageError(

                  errormessage: "Server Broke , Please try again later",
                  lottieimage: 'assets/logo/internalerror.json',

                );
              },), (route) => false);
            });
          }

          if(state is TokenNoInternet) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) {
                return PageError(

                  errormessage: "No Internet",
                  lottieimage: 'assets/logo/nointernet.json',

                );
              },), (route) => false);
            });
          }

          if(state is TokenLoading) {

              showDialog(context: context, builder: (context) {


               return  Center(

                 child: CircularProgressIndicator(
                   color: Color(AppColorConfig.bgcolor),

                 ),
               );

              },);
              //TODO check loading error here in case there red thing
              //
              // Future.delayed(Duration(seconds: 3),() => Navigator.pop(context),);



          }


        },
        child:
        Center(

          child: CircularProgressIndicator(
            color: Color(AppColorConfig.bgcolor),

          ),
        )

        // Center(
        //   child: CircularProgressIndicator(
        //     color: Color(AppColorConfig.success),
        //   )
        //
        //
        //
        // ),
      ),
    );
  }

  void setPreference() async {
    prefs = await SharedPreferences.getInstance();
    print("Event Obtain Token Sent");
    print(prefs?.getBool("islogin"));
    print("User id: ${ prefs!.getInt("userid")}");
    prefs!.getString('token');
    print(prefs!.getString('token'));
  print("My first use");
    print(prefs?.getBool("firstuse") );


   if( prefs?.getBool("firstuse") == null ) {
     print("User first use");
     prefs?.setBool("firstuse", false);
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return     StartScreen();
      },), (route) => false);
     return;
   }
    context.read<TokenBloc>().add(RefreshToken(prefs?.getString('refreshtoken')));
    // prefs!.remove("token");
    // prefs!.remove("userid");
  }

  loadinghere(context) {


  }
}
