
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/views/authentication/Login/LoginUI.dart';
import 'package:ecommerce/views/client/Home.dart';
import 'package:ecommerce/views/client/product/CreateProduct.dart';
import 'package:ecommerce/views/client/product/DiscoverScreen.dart';
import 'package:ecommerce/views/client/specialdeal.dart';
import 'package:ecommerce/views/order/Cart.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../viewmodel/products/address_bloc.dart';
import '../authentication/Login/LoginScreen.dart';
import '../order/OrderHistory.dart';
import 'MyOrder.dart';
import 'profile/ProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:line_icons/line_icon.dart';

class MyNavScreen extends StatefulWidget {
  var login;
  var uid;
  var token;
 MyNavScreen({Key? key,this.login,this.uid,this.token}) : super(key: key);

  @override
  State<MyNavScreen> createState() => _MyNavScreenState();
}

class _MyNavScreenState extends State<MyNavScreen> {
  var screenlist =[
    MyHomeScreen(),
    DiscoverScreen(),
    CartScreen(),
    OrderHistory(),
    MyProfileScreen()


  ];
  var title =[
    "Home",
    "Discover",
    "Cart",
    "Order",
    'Profile'
  ];
  var icon = [
    'assets/logo/home.png',
   'assets/logo/home.png',
    'assets/logo/paperclip-2.png',
    'assets/logo/shopping-bag.png',
    'assets/logo/profile.png'

  ];

  var iconlogo = [

      LineIcons.home,
       LineIcons.shoppingBag,
    LineIcons.shoppingCart,
    LineIcons.history,

    LineIcons.user
  ];
  var index = 0;
  var token ;
  var uid;
  var islogin = false;
  @override
  void initState() {
    // TODO: implement initState
    CheckAuthorize();
    super.initState();


  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CheckAuthorize();
    print(iconlogo.length);
  }
  void CheckAuthorize() async {
    print("print user id ");
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    uid = prefs.getInt("userid");
    prefs.getBool("islogin");

    token =   prefs.getString("token");
    print( prefs.getString("token"));
    islogin =   prefs.getBool("islogin") ?? false;
    print(  prefs!.getInt("userid"));



    BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid:  prefs!.getInt("userid")));
  }

  void ReviewAlert(BuildContext context) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        // backgroundColor: Color(AppColorConfig.primarylight),
        title: Text("Login or Register",style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(AppColorConfig.success),
        ),),
        content: Text("Require to login first before you can make an order",style: TextStyle(
          fontSize: 12.8,
          fontWeight: FontWeight.w400,

          color:Color(AppColorConfig.success),
        ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {

                // Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return loginScreen();
                },));
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
                  Text("Login",style: TextStyle(
                      fontSize: 14.8,
                      color: Color(AppColorConfig.primarylight)

                  ),)
                ],
              ))
        ],
      );
    },);
  }
  void PopUpUnauthorize(BuildContext context) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        // backgroundColor: Color(AppColorConfig.primarylight),
        title: Text("Login or Register",style: TextStyle(
            fontSize: 18,
         fontWeight: FontWeight.w500,
         color: Color(AppColorConfig.success),
        ),),
        content: Text("Require to login first before you can make an order",style: TextStyle(
            fontSize: 12.8,
            fontWeight: FontWeight.w400,

          color:Color(AppColorConfig.success),
        ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {

                // Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return loginScreen();
                },));
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
                  Text("Login",style: TextStyle(
                    fontSize: 14.8,
                    color: Color(AppColorConfig.primarylight)

                  ),)
                ],
              ))
        ],
      );
    },);
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    CheckAuthorize();
    return Scaffold(
      appBar: null,
      body: screenlist[index],
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 1,
      //   unselectedIconTheme: IconThemeData(
      //     color: Colors.grey,
      //
      //   ),
      //   showSelectedLabels: true,
      //   // showUnselectedLabels: true,
      //   selectedLabelStyle: TextStyle(
      //     color: Colors.black,
      //     fontSize: 12.8
      //   ),
      //   iconSize: 16,
      //   type:BottomNavigationBarType.fixed ,
      //   mouseCursor: MouseCursor.defer,
      //
      //
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: index,
      //
      //   unselectedLabelStyle: TextStyle(
      //     color:Colors.grey
      //   ),
      //   showUnselectedLabels: false,
      //
      //   selectedIconTheme: IconThemeData(
      //     color: Colors.black,
      //     size: 26
      //   ),
      //   onTap: (value) {
      //     setState(() {
      //       index = value;
      //       print(index);
      //     });
      //   },
      //
      //     items: List.generate(screenlist.length, (index) {
      //
      //     return  BottomNavigationBarItem(
      //
      //         backgroundColor: Colors.white,
      //
      //         // icon: Icon(icon[index]),label:title[index],
      //       icon: Image.asset(icon[index],
      //         fit: BoxFit.cover,
      //       width: 20,
      //         height: 20,
      //         color: Colors.black,
      //       ),
      //       label:title[index],
      //
      //     );
      //     },)
      //
      // ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: GNav(

          // rippleColor: Colors.grey, // tab button ripple color when pressed
          // hoverColor: Colors.grey, // tab button hover color
          haptic: true, // haptic feedback
          backgroundColor: Colors.black,
          onTabChange: (value) {


                if(value == 4 || value ==  3 ) {
                  if(token == null){
                    PopUpUnauthorize(context);
                  }
                  else{
                    setState(() {
                      index = value;
                      print(index);
                    });
                  }
                }
                else{
                  setState(() {
                    index = value;
                    print(index);
                  });
                }

                setState(() {

                });

          },




          // curve: Curves.bounceInOut, // tab animation curves
          activeColor: Colors.white,
          color: Colors.white,

          duration: Duration(milliseconds: 900), // tab animation duration
          gap: 8, // the tab button gap between icon and text/ unselected icon color/ selected icon and text color
          iconSize: 20, // tab button icon size
          tabBackgroundColor: Colors.grey.shade800, // selected tab background color
          padding: EdgeInsets.all(16),
          tabBorderRadius: 25,




          textStyle: TextStyle(
            color: Colors.white
          ),// navigation
          // tabs: [
          //   GButton(icon: Icons.home,text: 'Home',),
          //   GButton(icon: Icons.home,text: 'Home',),
          //   GButton(icon: Icons.home,text: 'Home',),
          //   GButton(icon: Icons.home,text: 'Home',)
          // ],
          tabs: List.generate(iconlogo.length, (index) {

        return       GButton(
             icon: iconlogo[index],



          text: '${title[index]}',);
        },),
        ),
      ),

      // floatingActionButtonLocation:
      //
      // FloatingActionButtonLocation.centerDocked,
      //
      // floatingActionButton:
      //
      // islogin == true ?
      // FloatingActionButton(
      //   isExtended: true,
      //   elevation: 0,
      //   backgroundColor: Colors.black,
      //   child: Icon(Icons.add),
      //
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //         return CreateProduct();
      //     },));
      //
      // },
      // ) : null,
    );
  }
}
