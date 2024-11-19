import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/User/user_bloc.dart';
import '../widget/Product/CutomButtonv2.dart';

class ReportScreen extends StatefulWidget {
  var uid;
  ReportScreen({Key? key,this.uid}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Future<void> launchurl(type, url) async {
    // if (!await launchUrl(url)) {
    //   throw Exception('Could not launch $url');
    // }
    print("url launch");
    if (type == "tele") {
      print("Sending teele");
      sendintent("tel", "+855965689895");
    }
    if (type == "email") {
      sendintent("mailto", "Nightpp19@gmail.com");
    }
    if (type == "bug") {
      txtdesc.clear();
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Send Us Message", style: TextStyle(
                  fontSize: 18,
                  color: Color(AppColorConfig.success)
              ),),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Icon(
                    Icons.close, color: Color(AppColorConfig.success),))
            ],
          ),


          content: SingleChildScrollView(
            child: Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Divider(),


                  // Text("Please report to us!!! ", style: TextStyle(
                  //     fontSize: 13.8,
                  //     color: Colors.black
                  // ),),
                  TextFormField(

                    cursorColor: Colors.grey,
                    style: TextStyle(
                        fontSize: 12.8,
                        color: Colors.black
                    ),

                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines:7,
                    controller: txtdesc,
                    onSaved: (newValue) {
                      setState(() {
                        txtdesc.text = newValue.toString();
                      });
                    },


                    decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.03),
                        filled: true,
                        hintText: "Tell us what happen!",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(

                              color: Colors.grey.withOpacity(0.3)
                          ),
                          borderRadius: BorderRadius.circular(4),

                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.3)
                            )

                        )
                    ),
                  )
                ],
              ),
            ),
          ),
          elevation: 0,
          actions: [
            ElevatedButton(


                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();



                  context.read<UserBloc>().add(SendMessage(txtdesc.text,
                      prefs.getInt("userid")));
                  txtdesc.clear();

                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColorConfig.success),
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


                    Text("Send", style: TextStyle(
                      fontSize: 14.8,

                    ),)
                  ],
                ))
          ],
        );
      },);
    }
  }

  Future<void> sendintent(scheme, path) async {
    final Uri launchUri = Uri(
      scheme: scheme,
      path: path,
    );

    await launchUrl(launchUri);
  }

  var txtdesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            // TODO: implement listener}
            if(state is UserMessageCompleted) {

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Thanks for feed back!!!", style: TextStyle(
                            fontSize: 18,
                            color: Color(AppColorConfig.success)
                        ),),

                      ],
                    ),
                    elevation: 0,
                    actions: [
                      ElevatedButton(
                          onPressed: ()=>Navigator.pop(context),




                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(AppColorConfig.success),
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
                              Text("Close", style: TextStyle(
                                fontSize: 14.8,

                              ),)
                            ],
                          ))
                    ],
                  );

                },);

              });
              BlocProvider.of<UserBloc>(context).add(FetchUser( widget.uid));

            }



            else{
              print("Error");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset('assets/lotties/help.json'),

                  Text("Need Help?", style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColorConfig.success)
                  ),),
                  Text(
                      "Contact us 24/7 by selecting any choice you prefer bellow",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Color(AppColorConfig.primaryswatchv2),
                      )
                  )


                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        padding: EdgeInsets.only(left: 20, right: 20,),
        child: Column(
          children: [

            BottomElevationBox(
              text: "CALL HOTLINE",
              padding: 13.0,
              type: "tele",
              onlaunch: launchurl,
              isoutline: false,

              textcolor: AppColorConfig.bgcolor,

              bgcolor: AppColorConfig.success,

            ),
            SizedBox(height: 10,),
            BottomElevationBox(
              text: "REPORT BUG",
              padding: 13.0,
              type: "bug",
              onlaunch: launchurl,
              isoutline: true,
              textcolor: AppColorConfig.success,
              bordercolor: AppColorConfig.success,

              bgcolor: AppColorConfig.bgcolor,

            ),
            SizedBox(height: 10,),
            BottomElevationBox(
              text: "SEND EMAIL",
              padding: 13.0,
              onlaunch: launchurl,
              type: "email",
              isoutline: true,
              textcolor: AppColorConfig.success,
              bordercolor: AppColorConfig.success,

              bgcolor: AppColorConfig.bgcolor,

            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}


