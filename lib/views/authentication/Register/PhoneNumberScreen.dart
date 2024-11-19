
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../viewmodel/authlogin/register_bloc.dart';

import 'CredentialScreen.dart';
import 'VerifyScreen.dart';
class PhoneNumberScreen extends StatefulWidget {
  var username;
  var lastname;
  var isowner ;
  var firstname;
  var gender;
  var email;
  var fullname;
  var id;
 PhoneNumberScreen({Key? key,
   this.isowner, this.username,
   this.lastname, this.firstname,this.gender,this.email,this.fullname,this.id }) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  var telephone = "234";
  var txttelephone = TextEditingController();
  var formtelephone = GlobalKey<FormState>();
  var iserror = true;
  var fnodetele = FocusNode();
  String? countries;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.email);
    print(widget.id);
    print(widget.username);

    txttelephone.addListener(() {
      final text = txttelephone.text;

      // if(formtelephone.currentState!.validate()) {
      //   formtelephone.currentState!.save();
      //
      // }
      // else{
      //
      // }

    });
    @override
    void dispose() {
      // Clean up the controller when the widget is removed from the widget tree.
      // This also removes the _printLatestValue listener.
      txttelephone.dispose();
      super.dispose();
    }
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    print(iserror );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppColorConfig.bgcolor).withOpacity(0.1),
        elevation: 0,
        actions: [
          if(iserror == false)
          TextButton(onPressed: () {
            // print(widget.username);
            // print(telephone);
            // print( countries);
            // print(   txttelephone.text );
            var userphone = "+" +telephone +  txttelephone.text;
            // print(userphone);

              if(widget.email !=null || widget.id  !=null){
                print("Send user google to");
                print(userphone);
                print(widget.username);
                print(widget.email);

              context.read<RegisterBloc> ().add(RegisterAuth(
                  password: widget.id,
                  email: widget.email,
                  telephone: userphone,
                  fullname: widget.username

                ));
              }
              else {
                print("credential user google to");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CredentialScreen(

                    firstname: widget.firstname,
                    lastname: widget.lastname,
                    username: widget.username,
                    isowner: widget.isowner,
                    tele: userphone,
                    gender: widget.gender,

                  );
                },));
              }

          }, child:Text("Next",style: TextStyle(
            fontSize: 12.8,
            color: Colors.black,
            fontWeight: FontWeight.w400

          ),))
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(

  listener: (context, state) {
    // TODO: implement listener}
    if(state is         RegisterAuthComplete) {
      storeemailandpass(widget.email,widget.id);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return VerifyScreen();
        },), (route) => false);
      });
    }

    if(state is RegisterGoogleAuthCompleted) {
      print("Google Register true");
      storeemailandpass(widget.email,widget.id);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return VerifyScreen();
        },), (route) => false);
      });
    }

    if(state is RegisterGoogleAuthLoading) {

      print("Loading Auth Register here");
      showDialog(context: context, builder: (context) {


        return  Center(

          child: CircularProgressIndicator(
            color: Color(AppColorConfig.bgcolor),

          ),
        );

      },);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      });
    }
  },
  child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
              return SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO image phone here
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
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your Phone",style: Theme.of(context).textTheme.headlineLarge,),
                          SizedBox(height: 5,),
                          Text("Please comfirm your country phone number and choose from the box bellow",
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                          //TODO form here
                          SizedBox(height: 15,),
                          Row(
                            children: [

                              Expanded(
                                child: Container(

                                  margin: EdgeInsets.only(top:0,bottom: 0),
                                  child: TextField(
                                    readOnly: true,
                                    focusNode: fnodetele,

                                    style: TextStyle(
                                        fontSize: 13
                                    ),

                                    onTap: ()=>    showCountryPicker(
                                      context: context,
                                      useSafeArea: true,

                                      countryListTheme: CountryListThemeData(
                                          backgroundColor: Colors.white,
                                          bottomSheetHeight: 700,
                                          searchTextStyle: TextStyle(
                                              fontSize: 12.8
                                          ),
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(bottom: 15),
                                          inputDecoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                fontSize: 12.8
                                            ),


                                            label: Text("Search country"),
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(7),
                                                borderSide: BorderSide.none
                                            ),
                                            floatingLabelStyle: TextStyle(
                                                color: Colors.black.withOpacity(0.5)
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(7),
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                )
                                            ),

                                            fillColor: Color(AppColorConfig.bgfill),



                                          )
                                      ),
                                      showPhoneCode: true, // optional. Shows phone code before the country name.
                                      onSelect: (Country country) {
                                        print('Select country: ${country.displayName}');
                                        setState(() {
                                          countries = country.name;
                                          telephone = country.phoneCode;
                                          fnodetele.nextFocus();

                                        });
                                      },
                                    ),
                                    decoration: InputDecoration(
                                        hintText:  countries ?? 'Country',

                                        filled: true,

                                        fillColor: Color(AppColorConfig.bgfill),

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
                          SizedBox(height: 15,),
                          //TODO select country

                          Row(
                            children: [


                              // SizedBox(width: 10,),
                              // Expanded(
                              //
                              //   child: Container(
                              //
                              //
                              //
                              //     child: Form(
                              //       child: TextFormField(
                              //         style: TextStyle(
                              //             fontSize: 13
                              //         ),
                              //
                              //         onTap: () {
                              //           setState(() {
                              //
                              //           });
                              //         },
                              //         readOnly: true,
                              //         decoration: InputDecoration(
                              //             filled: true,
                              //             hintText:'+' +telephone ?? '+000',
                              //
                              //             fillColor: Color(AppColorConfig.bgfill),
                              //
                              //             floatingLabelStyle: TextStyle(
                              //                 color: Colors.black
                              //             ),
                              //             border: OutlineInputBorder(
                              //                 borderSide: BorderSide.none,
                              //                 borderRadius: BorderRadius.circular(10)
                              //             )
                              //         ),
                              //
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                flex: 5,

                                child: Container(


                                  width: double.maxFinite,
                                  child: Form(


                                    key: formtelephone,
                                    autovalidateMode: AutovalidateMode.always,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          final phoneNumber = RegExp(r'^[1-9][0-9]{7,8}$');
                                          print("On telephone get call");
                                          if(txttelephone.text!.length == 0) {
                                            print("True true");
                                            iserror = true;

                                          }
                                          if(phoneNumber!.hasMatch(txttelephone.text!) == false) {
                                            print("True true");
                                            iserror = true;

                                          }
                                          else {
                                            print("No error anymore");
                                            iserror = false;

                                          }
                                        });

                                      },

                                      validator: (value) {
                                        final phoneNumber = RegExp(r'^[1-9][0-9]{7,8}$');

                                        if(value!.length == 0) {
                                          iserror = true;
                                          return "Phone number cannot be blank";
                                        }
                                        if(phoneNumber!.hasMatch(value!) == false) {
                                          iserror = true;
                                          return "Phone number must be eg:1234567890 without 0";
                                        }
                                        else {
                                          iserror = false;
                                          return null;
                                        }

                                      },


                                      style: TextStyle(
                                          fontSize: 13
                                      ),

                                      onTap: () {
                                        setState(() {

                                        });
                                      },
                                      keyboardType: TextInputType.phone,
                                      controller: txttelephone,

                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          if(formtelephone.currentState!.validate()) {
                                            formtelephone.currentState!.save();
                                          }

                                          txttelephone.text = value;

                                        });
                                      },
                                      decoration: InputDecoration(

                                          filled: true,



                                          fillColor: Color(AppColorConfig.bgfill),

                                          label: Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: Text("Telephone"),
                                          ),

                                          floatingLabelStyle: TextStyle(
                                              color: Colors.black
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          // prefixText: ?? '+000',
                                          prefix: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("+" + telephone ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                        // enabledBorder: OutlineInputBorder(
                                        //     // borderSide: BorderSide(
                                        //     //     // color: Colors.green
                                        //     // )
                                        // ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(AppColorConfig.success)
                                          )
                                        )
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )




                    //TODO register Phone num here
                  ],
                ),
              );
          },

        )
      ),
),
    );
  }

  void storeemailandpass(email,pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email",email);
    prefs.setString("pass", pass);
  }


}
