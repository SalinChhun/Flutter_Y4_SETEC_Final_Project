import 'dart:io';
import 'package:ecommerce/views/widget/LoadingIcon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/User/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/Ulti/Genders.dart';
import '../../../model/Users/UserModel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../viewmodel/image_bloc.dart';

class EditingProfile extends StatefulWidget {

  UserModel? user;

  EditingProfile({Key? key, this.user}) : super(key: key);

  @override
  State<EditingProfile> createState() => _EditingProfileState();
}

class _EditingProfileState extends State<EditingProfile> {
  var txtemail = TextEditingController();
  var txtfirstname = TextEditingController();
  var telephone = "234";
  var txttelephone = TextEditingController();
  var txtusername = TextEditingController();
  var formtelephone = GlobalKey<FormState>();
  var iserror = true;
  String? countries;
  bool istap = false;

  Imgid? imgid;
  var genderlist = [Genders.Male.name, Genders.Female.name, Genders.Other.name];
  var gender = Genders.Male.name;
  var txtlname = TextEditingController();
  var imagefile;
  var imageid;

  @override
  void initState() {
    // TODO: implement initState
    setUserBinding(widget.user!);
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    print("user image");
    print(  widget.user?.imgid?.images );
    print("Image uploaded id is  ${imageid}");
    print(widget.user?.imgid?.id);
    return Scaffold(
      appBar: AppBar(

          title: Text("Edit Profile", style: TextStyle(
              color: Colors.white
          ),),
          backgroundColor: Colors.black,

          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          actions: [
            BlocListener<ImageBloc, ImageState>(
              listener: (context, state) {
                // TODO: implement listener
                print(state);
                if (state is ImageUpCompleted) {
                  print("Image has been uploaded");
                  print(state.imageResponse?.url!.id);


                  WidgetsBinding.instance.addPostFrameCallback(

                          (timeStamp) {
                    setState(() {
                      imageid = state.imageResponse?.url!.id;
                    });
                  });


                }
                if (state is ImageUpError) {
                  print("Error has been occur");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      print("Event Edit");
                      print(txtfirstname.text);
                      print(imageid);
                      print(widget?.user?.id.toString());


                      if(iserror == true) {
                        showDialog(context: context, builder: (context) {


                          return  Center(

                            child: CircularProgressIndicator(
                              color: Color(AppColorConfig.bgcolor),

                            ),
                          );

                        },);
                        Future.delayed(Duration(seconds: 2),() {
                          Navigator.pop(context);
                        },);

                        return;
                      }

                      if (widget.user?.imgid?.id != null) {
                        print("Image uploaded id is  ${imageid}");
                        if(imagefile == null ) {
                          imageid = widget.user?.imgid?.id;
                        }
                        else {
                          imageid = imageid;
                        }

                        print("Telephone ${telephone}${txttelephone.text}");
                        BlocProvider.of<UserBloc>(context, listen: false).add(
                            EditUser(
                                fname: txtfirstname.text,
                                gender: gender,
                                telephone: telephone + txttelephone.text,
                                imgid:



                                imageid.toString(),
                                userid: widget?.user?.id.toString(),
                                lastname: txtlname.text,
                                username: txtusername.text
                            ));


                      }
                      else {
                        print("Image id is not null");
                        print(imageid);
                        // if(imageid == null) {
                        //   imageid = 1;
                        // }
                        print("Telephone ${telephone}${txttelephone.text}");
                        BlocProvider.of<UserBloc>(context, listen: false).add(
                            EditUser(
                                fname: txtfirstname.text,
                                gender: gender,
                                telephone: telephone + txttelephone.text,

                                imgid:imageid.toString(),
                                userid: widget?.user?.id.toString(),
                                lastname: txtlname.text,
                                username: txtusername.text
                            ));


                      }



                    },

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.check),
                    )),
              ),
            )
          ],


          elevation: 0),
      body: SafeArea(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            print(state);
            // TODO: implement listener}

            if (state is LoadingUserDone) {
              print("Edit Profile has been updated");

              // Navigator.pop(context);





              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

                ScaffoldMessenger.of(context).showSnackBar(

                    SnackBar(
                        content: Text("Profile has been updated"),
                      backgroundColor: Color(AppColorConfig.success),


                    ));



              });
              Navigator.pop(context);
            }

            if (state is LoadingUser) {

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                showDialog(context: context, builder: (context) {


                  return  Center(

                    child: CircularProgressIndicator(
                      color: Color(AppColorConfig.bgcolor),

                    ),
                  );

                },);
                Future.delayed(Duration(seconds:1),() => Navigator.pop(context),);
              });
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocListener<ImageBloc, ImageState>(
                    listener: (context, state) {
                      // TODO: implement listener

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15),

                      child: Center(

                        child: Column(
                          children: [
                            // widget.user?.imgid?.images == null ?
                            //
                            //
                            // CircleAvatar(
                            //   radius:
                            //
                            //   imagefile == null ?
                            //   70 : 0,
                            //   backgroundColor:
                            //
                            //   imagefile == null ?
                            //
                            //   Color(0xffF0F0F0) : null,
                            //   child:
                            //   widget.user?.imgid?.images == null ?
                            //
                            //   Icon(Icons.add,
                            //
                            //
                            //     size: imagefile == null ? 30 : 0,
                            //     color: Colors.black.withOpacity(0.5),) : null ,
                            //
                            //
                            // )
                            //     :
                            //
                            //
                            // CircleAvatar(
                            //   radius: 70,
                            //   backgroundColor: Color(0xffF0F0F0),
                            //   backgroundImage:
                            //
                            //
                            //   NetworkImage(
                            //       '${ApiUrl.main}${widget.user?.imgid
                            //           ?.images }')
                            //
                            //
                            //   ,
                            //   child:
                            //   widget.user?.imgid?.images == null ?
                            //
                            //   Icon(Icons.add, size: 30,
                            //     color: Colors.black.withOpacity(0.5),) : null,
                            //
                            //
                            // ),

                         imagefile != null  ?


                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Color(0xffF0F0F0),
                                backgroundImage:


                                FileImage(imagefile)


                                ,


                              ) :

                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Color(0xffF0F0F0),
                              backgroundImage:


                              NetworkImage(
                                  '${"https://django-ecomm-6e6490200ee9.herokuapp.com"}${widget.user?.imgid
                                      ?.images }')


                              ,
                              child:
                              widget.user?.imgid?.images == null ?

                              Icon(Icons.add, size: 30,
                                color: Colors.black.withOpacity(0.5),) : null,


                            ),


                            SizedBox(height: 11,),
                            InkWell(
                              onTap: () => imagepickermethod()
                              ,
                              child: Text(
                                'Edit profile or avatar', style: TextStyle(
                                  fontSize: 12.8,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400

                              ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 45,
                  //   margin: EdgeInsets.only(top: 25),
                  //   child: TextField(
                  //     style: TextStyle(
                  //
                  //         fontSize: 13
                  //     ),
                  //     controller: txtemail,
                  //     onSubmitted: (value) {
                  //       setState(() {
                  //         txtemail.text = value;
                  //       });
                  //     },
                  //
                  //     onTap: () {
                  //       setState(() {
                  //         istap = false;
                  //       });
                  //     },
                  //     decoration: InputDecoration(
                  //         filled: true,
                  //
                  //         fillColor: Color(AppColorConfig.bgfill),
                  //         label: Text("Email"),
                  //         floatingLabelStyle: TextStyle(
                  //             color: Colors.black
                  //         ),
                  //         border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //             borderRadius: BorderRadius.circular(10)
                  //         )
                  //     ),
                  //
                  //   ),
                  // ),

                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(

                      style: TextStyle(

                          fontSize: 13
                      ),

                      onSubmitted: (value) {
                        setState(() {
                          txtlname.text = value;
                        });
                      },
                      cursorColor: Colors.grey,
                      controller: txtlname,
                      onTap: () {

                      },


                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          filled: true,



                          fillColor: Color(AppColorConfig.bgfill),

                          label: Text("Lastname"),
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


                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      style: TextStyle(

                          fontSize: 13
                      ),
                      controller: txtfirstname,

                      onSubmitted: (value) {
                        setState(() {
                          txtfirstname.text = value;
                        });
                      },             cursorColor: Colors.grey,
                      textInputAction: TextInputAction.next,

                      onTap: () {

                      },
                      decoration: InputDecoration(
                          filled: true,

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

                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(6),

                    ),
                    child: DropdownButton(
                      elevation: 0,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 0),
                      underline: SizedBox(),


                      // Initial Value
                      value: gender,


                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      alignment: Alignment.center,
                      isExpanded: true,
                      style: TextStyle(
                          fontSize: 12.8, color: Colors.black,
                          fontWeight: FontWeight.w400

                      ),

                      // Array list of items
                      items: genderlist.map((items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.toString()),
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                      // After selecting the desired option,it will
                      // change button value to selected value


                    ),
                  ),

                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      style: TextStyle(

                          fontSize: 13
                      ),
                      controller: txtusername,
                      cursorColor: Colors.grey,
                      textInputAction: TextInputAction.next,

                      onSubmitted: (value) {
                        setState(() {
                          txtusername.text = value;
                        });
                      },

                      onTap: () {

                      },
                      decoration: InputDecoration(
                          filled: true,

                          fillColor: Color(AppColorConfig.bgfill),
                          label: Text("Username"),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //TODO form here

                      Container(

                        margin: EdgeInsets.only(top: 25, bottom: 15),
                        child: TextField(
                          readOnly: true,

                          style: TextStyle(
                              fontSize: 13
                          ),

                          onTap: () =>
                              showCountryPicker(
                                context: context,
                                useSafeArea: true,

                                countryListTheme: CountryListThemeData(
                                    backgroundColor: Colors.white,
                                    bottomSheetHeight: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.9,
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
                                          borderRadius: BorderRadius.circular(
                                              7),
                                          borderSide: BorderSide.none
                                      ),
                                      floatingLabelStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              7),
                                          borderSide: BorderSide(
                                              color: Colors.black
                                          )
                                      ),

                                      fillColor: Color(AppColorConfig.bgfill),


                                    )
                                ),
                                showPhoneCode: true,

                                // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  print(
                                      'Select country: ${country.displayName}');
                                  setState(() {
                                    countries = country.name;
                                    telephone = country.phoneCode;
                                  });
                                },
                              ),
                          decoration: InputDecoration(
                              hintText: countries ?? 'Country',

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
                      //TODO select country

                      Row(
                        children: [

                          Expanded(

                            child: Container(
                              height: 200,

                              width: double.maxFinite,
                              child: TextFormField(


                                style: TextStyle(
                                    fontSize: 13
                                ),


                                onTap: () {
                                  setState(() {

                                  });
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: telephone ?? '+000',

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
                          SizedBox(width: 10,),

                          Expanded(
                            //TODO telephone here
                            flex: 2,
                            child: Container(
                              height: 200,


                              width: double.maxFinite,
                              child: Form(
                                key: formtelephone,

                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.grey,
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
                                      label: Text("Telephone"),
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
                        ],
                      ),

                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setUserBinding(UserModel user) {
    txtemail.text = user!.email!;

    txtfirstname.text = user!.firstname!;
    txtlname.text = user!.lastname!;
    txtusername.text = user!.username!;
    gender = user!.gender!;
    print(user!.telephone!.substring(0, 4));
    telephone = user!.telephone!.substring(0, 4);
    txttelephone.text = user!.telephone!.substring(4);
  }

  Future<void> imagepickermethod() async {
    final selectedimg = await ImagePicker().pickImage(

      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,

    );
    if (selectedimg == null) {
      return;
    }
    setState(() {
      imagefile = File(selectedimg!.path);
      print(imagefile);

      context.read<ImageBloc>().add(UploadImage(selectedimg!.path.toString()));
    });
  }
}
