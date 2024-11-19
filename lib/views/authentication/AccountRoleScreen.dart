
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/auth/customregister.dart';
import '../widget/other/templatescreen.dart';

import 'Register/PhoneNumberScreen.dart';


class AccountRoleScreen extends StatefulWidget {
  var username;
  var lastname;
  var firstname;
   AccountRoleScreen({Key? key,this.username,this.lastname,this.firstname}) : super(key: key);

  @override
  State<AccountRoleScreen> createState() => _AccountRoleScreenState();
}

class _AccountRoleScreenState extends State<AccountRoleScreen> {
  var isowner = false;

 var isselect = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.username);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppColorConfig.bgcolor).withOpacity(0.1),
        elevation: 0,
        actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return  PhoneNumberScreen(isowner: isselect,

                username: widget.username,
                lastname: widget.lastname ,

                firstname: widget.firstname,


              );
            },));
          }, child:Text("Next",style: TextStyle(
              fontSize: 12.8,
              color: Colors.black,
              fontWeight: FontWeight.w400

          ),))
        ],
      ),
      body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO image phone here

                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Account Role",style: Theme.of(context).textTheme.headlineLarge,),
                          SizedBox(height: 5,),
                          Text("Choosing role or position for your purpose of using",
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight*0.45,
                      child: Column(
                        children: [
                          Center(
                            child: Lottie.asset("assets/lotties/phonenumber.json",
                                fit: BoxFit.cover,
                                height: 90,
                                width:constraints.maxWidth*0.75
                            ),
                          ),

                        ],
                      ),
                    ),

                    //TODO here
                    Container(
                      margin: EdgeInsets.only(top: 5,bottom: 0,left: 15,right: 15),
                      width: double.maxFinite,
                      child: ElevatedButton(

                        style:
                        isselect == true ?
                        ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor:


                            Color(AppColorConfig.primarycolor)
                          ,
                          padding: EdgeInsets.all(10),

                        ) :
                        ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Colors.black
                            )

                        ),

                        backgroundColor: Color(AppColorConfig.bgcolor),
                        padding: EdgeInsets.all(10),

                      )

                        ,
                        onPressed: () {
                          setState(() {
                            if(isselect == true) {

                            }
                            else{
                              isselect =! isselect;
                            }

                            print(isselect);
                          });

                        }, child:Text("I am a sole business i have my own brand product ",
                        textAlign: TextAlign.center,
                        style:
                       TextStyle(
                         fontSize: 12.8,
                          color: isselect == false ?
                           Colors.black : Colors.white
                       ),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,bottom: 0,left: 15,right: 15),
                      width: double.maxFinite,
                      child: ElevatedButton(

                        style:
                            isselect == false ?
                        ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor:
                          isowner == true ?
                          Color(AppColorConfig.primarycolor) :

                          Color(AppColorConfig.primarycolor)
                          ,
                          padding: EdgeInsets.all(10),

                        )
                            :

                        ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black
                            )

                          ),

                          backgroundColor: Color(AppColorConfig.bgcolor),
                          padding: EdgeInsets.all(10),

                        ),
                        onPressed: () {
                          setState(() {
                            if(isselect == false) {

                            }
                            else{
                              isselect =! isselect;
                            }
                          });
                        }, child:Text("I am looking to buy online product ",
                        textAlign: TextAlign.center,

                        style:
                        TextStyle(
                            fontSize: 12.8,
                          color:
                          isselect == true ?
                          Colors.black : Colors.white
                        ),),
                      ),
                    ),



                    //TODO register Phone num here
                  ],
                ),
              );
            },

          )
      ),
    );
  }
}
