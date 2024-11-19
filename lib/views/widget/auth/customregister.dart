

import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/res/constant/stripesecretkey.dart';
import 'package:ecommerce/viewmodel/authlogin/register_bloc.dart';
import 'package:ecommerce/views/authentication/Register/PhoneNumberScreen.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../model/Ulti/Genders.dart';
import '../../../service/auth_service.dart';
import '../../authentication/AccountRoleScreen.dart';
import '../../authentication/Login/LoginScreen.dart';
import '../../client/Home.dart';
class RegisterForm extends StatefulWidget {
 RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var istap = false;
  Map<String, dynamic >? paymentintent;

  var fname = TextEditingController();
  var lname = TextEditingController();
  var username = TextEditingController();
  var formfnamekey = GlobalKey<FormState>();
  var formlnamekey = GlobalKey<FormState>();
  var formusernamekey = GlobalKey<FormState>();
  var genderlist = [Genders.Male.name,Genders.Female.name,Genders.Other.name];
  var gender =Genders.Male.name;
  var isfnameerror = true;
  var islnameerror = true;
  var isusernameerror = true;
  var openmenu = false;
  AuthService auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  Widget build(BuildContext context) {
    return SingleChildScrollView(


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              SizedBox(height: 20,),
          //TODO login gmail or facebook here
          Container(
            width: MediaQuery.of(context).size.width*1,
            margin: EdgeInsets.only(bottom: 20),


            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {

                     var user = await auth.signInWithGoogle() as Map<String,String?>;

                     print(user["email"]);
                     print(user["id"]);
                     print(user["displayname"]);
                     if(user["email"] == null ) {
                       print("User Cancel");
                     }
                     else {
                       if(user!=null) {
                         //TODO push to telephone number
                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                           return  PhoneNumberScreen(
                             email: user["email"],
                             username: user["displayname"],
                             id: user["id"],

                             isowner: false,

                           );
                         },));
                       }
                     }




                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: Color(AppColorConfig.bgcolor).withOpacity(0.85),
                      padding: EdgeInsets.all(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo/Google.png'),
                        SizedBox(width: 10,),
                        Text("Google",style: TextStyle(
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
                    icon:Icon(Icons.person) ,
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
          //TODO Bar

          Container(
            width: MediaQuery.of(context).size.width*1,
            margin: EdgeInsets.only(bottom: 20),


            child:     Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1,

                  ),
                ),
                SizedBox(width: 10,),
                Text("Or",style: TextStyle(
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
          ),

          Container(

            margin: EdgeInsets.only(top: 25),
            child: Form(
              key: formfnamekey,

              child: TextFormField(
                style: TextStyle(
                    fontSize: 13
                ),cursorColor: Colors.grey,
                controller: fname,
                validator: (value) {
                  if(value!.length == 0 || value.isEmpty) {
                    return "Firstname cannot leave it blank";
                  }
                  // else if(value!.length == 0 || value.isEmpty) {
                  //   return "Firstname cannot leave it blank";
                  // }
                  else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  if(value!.length == 0 || value.isEmpty) {
                    isfnameerror = true;
                  }
                  // else if(value!.length == 0 || value.isEmpty) {
                  //   return "Firstname cannot leave it blank";
                  // }
                  else {
                    isfnameerror = false;

                  }
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    if(formfnamekey.currentState!.validate()) {
                      formfnamekey.currentState!.save();
                    }
                    fname.text = value;
                  });
                },

                onTap: () {
                  setState(() {
                    istap =false;
                  });
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    filled: true,
                    // suffixIcon: InkWell(
                    //   onTap: () => fname.clear(),
                    //   child: Icon(Icons.clear),
                    // ),


                    fillColor: Color(AppColorConfig.bgfill),
                    label: Text("Firstname"),
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
            //TODO form here
          Container(
            // height: 45,
            margin: EdgeInsets.only(top: 25),
            child: Form(
              key: formlnamekey,
              child: TextFormField(
                cursorColor: Colors.grey,
                style: TextStyle(
                    fontSize: 13
                ),

                onTap: () {
                  setState(() {
                    istap =false;
                  });
                },
                controller: lname,
                textInputAction: TextInputAction.next,

                autovalidateMode:  AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if(value.toString().length == 0 ||value!.isEmpty ) {
                    return "Lastname cannot be blank";
                  }
                  // else if(){
                  //
                  // }
                  else{
                    return null ;
                  }
                },
                onChanged: (value) {
                  if(value.toString().length == 0 ||value!.isEmpty ) {
                    islnameerror = true;
                  }
                  // else if(){
                  //
                  // }
                  else{
                    islnameerror = false;

                  }
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    if(formlnamekey.currentState!.validate()) {
                      formlnamekey.currentState!.save();
                    }
                    lname.text = value;

                  });
                },
                decoration: InputDecoration(
                    filled: true,
                    // suffixIcon: InkWell(
                    //   onTap: () => lname.clear(),
                    //   child: Icon(Icons.clear),
                    // ),

                    fillColor: Color(AppColorConfig.bgfill),
                    label: Text("lastname"),
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
          Container(

            margin: EdgeInsets.only(top: 25),
            child: Form(
              key: formusernamekey,

              child: TextFormField(
                cursorColor: Colors.grey,
                style: TextStyle(
                    fontSize: 13
                ),

                onTap: () {

                },
                controller: username,
                autovalidateMode:  AutovalidateMode.onUserInteraction,
                validator: (value) {
                  final regexp = RegExp(r'^([^0-9]*)$');

                  if(value.toString().length == 0) {
                      return "Username cannot leave it blank";
                  }
                  else if(value.toString().length <= 4){
                    return "Username must be at least 4 character";
                  }
                  print(regexp.hasMatch(value!) );
                  if(regexp.hasMatch(value!) == false){

                    return "Username cannot be numeric only";
                  }
                  else {
                    return null;
                  }
                },
                onChanged: (value) {
                  final regexp = RegExp(r'^([^0-9]*)$');

                  if(value.toString().length == 0) {
                    isusernameerror = true;
                  }
                  else if(value.toString().length <= 4){
                    isusernameerror = true;
                  }
                  print(regexp.hasMatch(value!) );
                  if(regexp.hasMatch(value!) == false){

                    isusernameerror = true;
                  }
                  else {
                    isusernameerror = false;
                  }
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    if(formusernamekey.currentState!.validate()) {
                      formusernamekey.currentState!.save();
                    }
                    username.text = value;
                  });
                },

                decoration: InputDecoration(
                    filled: true,
                    // suffixIcon: InkWell(
                    //   onTap: () => username.clear(),
                    //   child: Icon(Icons.clear),
                    // ),





                    label: Text("username"),
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
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffF1F1F1),
              borderRadius: BorderRadius.circular(6),

            ),
            child: DropdownButton(
              elevation: 0,
              dropdownColor: Color(AppColorConfig.primarylight),

              autofocus: true,

              padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
              underline: SizedBox(),
          onTap: () {
            print("True");
            setState(() {
              openmenu = true;
              print("F");
            });
          },


              // Initial Value
              value:gender  ,



              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              isExpanded: true,


              style: TextStyle(
                  fontSize: 12.8,color: Colors.black,
                  fontWeight: FontWeight.w400,


              ),

              // Array list of items
              items: genderlist.map((items) {
                return DropdownMenuItem(
                  enabled: true,

                  value: items,
                  // alignment: Alignment.center,
                  child: Text(items.toString()),
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  gender   = value!;

                });
              },
              // After selecting the desired option,it will
              // change button value to selected value


            ),
          ),
          SizedBox(height: 15,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //
          //     Text('forget password?',textAlign: TextAlign.right,style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 12.8
          //     ),),
          //   ],
          // ),
          SizedBox(height: 5,),

          Container(
            margin: EdgeInsets.only(top: 15,bottom: 15),
            width: double.maxFinite,
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: Color(AppColorConfig.primarycolor),
                padding: EdgeInsets.all(10),

              ),
              onPressed: () {
                //TODO login Register here
                print(username.text);
                var iserror = true;

                if(formfnamekey.currentState!.validate()  ) {
                  formfnamekey.currentState!.save();
                  iserror = false;

                }

                if(formlnamekey.currentState!.validate()){
                  formlnamekey.currentState!.save();
                  iserror = false;
                }

                if(formusernamekey.currentState!.validate() ){
                  formusernamekey.currentState!.save();
                  iserror = false;
                }


                if(isusernameerror == true || islnameerror == true || isusernameerror == true){
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
                  Future.delayed(Duration(seconds: 2),() => Navigator.pop(context),);
               context.read<RegisterBloc>().add(RegisterValidate());
                        return;
                }



                showDialog(context: context, builder: (context) {


                  return  Center(

                    child: CircularProgressIndicator(
                      color: Color(AppColorConfig.bgcolor),

                    ),
                  );

                },);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  PhoneNumberScreen(
                    firstname: fname.text,
                    lastname: lname.text,
                    username: username.text,
                    isowner: false,
                    gender: gender,
                  );
                },));



              }, child:Text("Register",
              textAlign: TextAlign.center,
              style:
              Theme.of(context).textTheme.displaySmall,),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
                  return  loginScreen(


                  );
                },), (route) {
                  return false;
                },);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text('Already have an account? Login Now',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.8
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 7,),
        ],
      ),
    );
  }


}



