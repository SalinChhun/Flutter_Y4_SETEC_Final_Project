import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../viewmodel/authlogin/login_bloc.dart';
import '../../widget/auth/customlogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginUI extends StatefulWidget {
  var errormessage;

  LoginUI({Key? key, this.errormessage}) : super(key: key);

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("changge");
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener}
          print(state);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          mainAxisSize: MainAxisSize.max,
          children: [
            //TODO image
            Container(

              child: Image.asset('assets/images/imageview1.png',
                width: double.maxFinite,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.30,


                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,


              ),
            ),

            LoginForm(error: widget.errormessage,)

            //TODO login part here


          ],
        ),
      ),
    );
  }

  void showAlertLoginWrong(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Unauthorize"),
      );
    },);
  }
}
