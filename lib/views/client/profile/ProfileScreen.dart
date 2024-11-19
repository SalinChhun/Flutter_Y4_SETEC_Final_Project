import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/User/user_bloc.dart';
import 'package:ecommerce/views/client/profile/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res/appurl/appurl.dart';
import '../../Address/AddressScreen.dart';
import '../../ErrorPage.dart';
import '../../authentication/Require.dart';
import '../../authentication/ResetPassword/ResetPassword.dart';
import '../../order/Cart.dart';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/LoadingIcon.dart';
import '../ReportBug.dart';
import 'MyWishList.dart';

class MyProfileScreen extends StatefulWidget {

   MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  var positionlong;
  // var userid;

  var positionlat;

  Future<void> currentUserLocation() async {
    var location = await Location().getLocation();
    print("User current location");
    print(location.longitude);
    print(location.latitude);

    positionlong = location.longitude;
    positionlat = location.latitude;
  }

  var islogin;
  var uid;

  @override
  void initState() {
    // TODO: implement initState
    CheckAuthorize();
    print("User profile");
    print("Profile screen");
    super.initState();



  }

  void CheckAuthorize() async {
    print("print user id ");
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    prefs.getInt("userid");
    prefs.getBool("islogin");
    islogin = prefs.getBool("islogin") ?? false;
    print(prefs.getInt("userid"));
    print("userid");
   uid = prefs.getInt("userid");
    print("print user id  ${uid}");

    BlocProvider.of<UserBloc>(context).add(FetchUser( uid));

  }

  void PopUpUnauthorize(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Login or Register", style: TextStyle(
            fontSize: 18,
            color: Color(AppColorConfig.success)
        ),),
        content: Text("Require to login first before you can make an order",
          style: TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w400,

              color: Colors.black
          ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {
                print('press press');
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

                  SizedBox(width: 10,),
                  Text("Login", style: TextStyle(
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
    print("Profile screen ${uid}");

    BlocProvider.of<UserBloc>(context).add(FetchUser( uid));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

          title: Text("My Account", style: TextStyle(
              color: Colors.black
          ),),
          iconTheme: IconThemeData(
              color: Colors.black
          ),

          backgroundColor: Colors.white,
          elevation: 0),
      body: SafeArea(

        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            // TODO: implement listener
            print("profile current state");
            print(state);

          },
          builder: (context, state) {

            if(state is LoadingUser){
              return LoadingIcon();
            }
            if(state is LoadingUserError){
           return const ErrorPage();
            }
            if(state is LoadingUserDone){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //TODO top profile detail
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffC2E5DF),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage:



                              NetworkImage(

                                  state.user?.imgid?.images == null ?
                                      'https://i.pinimg.com/originals/f2/12/06/f21206832d2993b70a015fc1e56ee72c.jpg':
                                  '${"https://django-ecomm-6e6490200ee9.herokuapp.com"}${state.user?.imgid?.images}'

                              ),


                            ),
                            title: Text('${state.user?.username.toString().toUpperCase()}', style: TextStyle(
                                color: Colors.black
                            ),),
                            subtitle: Text(
                              'Customer Since ${state.user?.createdDate.toString().substring(0,4)}', style: TextStyle(
                                fontSize: 12.8
                            ),),
                            trailing: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,

                                        builder: (context) {
                                          return EditingProfile(

                                            user: state.user,
                                          );
                                        },));
                                },


                                child: Icon(Icons.settings)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Row(
                              children: [
                                Icon(Icons.mail, size: 16,),
                                SizedBox(width: 10,),
                                Text('${state.user?.email}', style:
                                TextStyle(fontSize: 12.8),)
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 22, bottom: 19),
                            child: Row(
                              children: [
                                Icon(Icons.phone, size: 16,),
                                SizedBox(width: 10,),
                                Text('${state.user?.telephone}', style:
                                TextStyle(fontSize: 12.8),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    //TODO profile Setting

                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          ListTile(

                            leading: Image.asset('assets/logo/Location.png',
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,


                              alignment: Alignment.center,

                            ),

                            title: Text('Address', style: TextStyle(
                                color: Colors.black
                            ),),

                            trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                            onTap: () async {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) {
                                return AddressProductScr(userid:    uid ,);
                              },));
                            },
                          ),
                          // Divider(),
                          // ListTile(
                          //   leading: Image.asset('assets/logo/Wallet.png',
                          //     fit: BoxFit.cover,
                          //     width: 24,
                          //     height: 24,
                          //
                          //
                          //     alignment: Alignment.center,
                          //
                          //   ),
                          //
                          //   title: Text('Payment Method', style: TextStyle(
                          //       color: Colors.black
                          //   ),),
                          //
                          //   trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          // ),
                          Divider(),
                          ListTile(

                            onTap: () {
                              if (islogin == true) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return CartScreen();
                                    },));
                              }
                              if (islogin == false) {
                                PopUpUnauthorize(context);
                              }
                            },
                            leading: Image.asset('assets/logo/Ticket.png',
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,


                              alignment: Alignment.center,

                            ),

                            title: Text('My Cart', style: TextStyle(
                                color: Colors.black
                            ),),

                            trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return MyWishScreen(uid: uid,);
                              },));
                            },
                            // leading: Image.asset('assets/logo/Favorite_fill.png',
                            //   fit: BoxFit.cover,
                            //   width: 24,
                            //   height: 24,
                            //
                            //
                            //   alignment: Alignment.center,
                            //
                            // ),
                            leading: Icon(Icons.favorite,color: Colors.black,),

                            title: Text('My WishList', style: TextStyle(
                                color: Colors.black
                            ),),

                            trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () {
                              print(state?.user?.email);
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ResetPassword(
                                  email: state?.user?.email,


                                );
                              },));
                            },
                            leading: Image.asset('assets/logo/eye.png',
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,


                              alignment: Alignment.center,

                            ),

                            title: Text('Changed Password', style: TextStyle(
                                color: Colors.black
                            ),),

                            trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ReportScreen(

                                uid: state.user?.id,
                              );
                            },)),
                            leading: Image.asset('assets/logo/volume-2.png',
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,


                              alignment: Alignment.center,

                            ),

                            title: Text('Report Bug and Issues', style: TextStyle(
                                color: Colors.black
                            ),),

                            trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () {
                              clearalltoken();
                              Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context) {
                                return RequireLoginandSignup();
                              },), (route) => false,);
                            },
                            leading: Image.asset('assets/logo/Logout.png',
                              fit: BoxFit.cover,
                              width: 24,
                              height: 24,


                              alignment: Alignment.center,

                            ),

                            title: Text('Log Out', style: TextStyle(
                                color: Colors.black
                            ),),

                            trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return LoadingIcon();
            }

          },
        ),
      ),

    );
  }

  void clearalltoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("key removed ");
    // prefs.setBool("islogin",true);
    // prefs.setString("userid", userid);
    prefs?.remove("islogin");

    prefs?.remove("userid");

    prefs?.remove("token");
  }
}
