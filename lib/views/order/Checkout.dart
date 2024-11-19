
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/products/address_bloc.dart';

import 'package:ecommerce/views/order/Success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/res/constant/stripesecretkey.dart';
import '../../helper/GoogleLocation.dart';
import '../../helper/HexColorConverter.dart';
import '../../helper/StripeService.dart';
import '../../model/Address.dart';
import '../../model/Order/OrderRequest.dart';
import '../../model/Product/CartModel.dart';
import '../../service/GoogleMap/GoogleMapScreen.dart';
import '../../viewmodel/order/order_bloc.dart';
import '../Address/AddressScreen.dart';
import '../testpayment.dart';
import '../widget/LoadingIcon.dart';
import '../widget/Product/FloatingAction.dart';
import 'package:lottie/lottie.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CompleteOrder.dart';
class Checkout extends StatefulWidget {
  List<CartItem>? cartitem;

  var subtotal;
  var qtytotal;

  var discount;
  var uid;
  var imgid;
  var sizeid;

  Checkout ({Key? key,this.cartitem,this.subtotal,this.discount,this.qtytotal,this.uid,this.imgid,this.sizeid}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Map<String, dynamic>? paymentintent;
 var address;
 var imagepreviewurl;
 var selectedIndexAddress = 0;
 var indexchose =0;
 var initpayment = 0;
 var selectedmethod = 0;
  int? addressid;
  var userinput = TextEditingController();
  var long;
  var lat;
  var mapofaddress;
  var istap = true;
  var showiconpwd = false;
  var homeadd;
  var city;
  var country;
  var userid;
  var iserrordesc = true;
  var txtdesc = TextEditingController();
  var formdesc =  GlobalKey<FormState>();
    var add ;
  LocationHelper locationhelper = LocationHelper();
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid: widget.uid));
    super.initState();
    print("Checkout userid");
    print(widget.uid);



    // BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid: widget!.uid));
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }
  SendLatandLong(lat, long) async {

    mapofaddress = await locationhelper.getPlaceWithLatLng(lat, long);

      print('call');
      print(mapofaddress);

      print(mapofaddress[5]["address_components"][5]["long_name"]);
      homeadd = mapofaddress[0]['formatted_address'];
      // print(mapofaddress[0]["address_components"][6]["long_name"]);
      country = mapofaddress[0]["address_components"][6]["long_name"];
      city = mapofaddress[5]["address_components"][5]["long_name"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<AddressBloc>(context, listen: false)
        .add(PostAddress(
        add: AddressBody(
          city: city,
          country: country,
          lat:lat,
          lon: long,
          street: homeadd,



        ),
        userid: prefs?.getInt('userid'),
        desc: txtdesc.text
    ));

  }

  void PopUpUnauthorize(BuildContext context) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Missing Delivery Address",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize:22,
            fontWeight: FontWeight.w500,

            color: Color(AppColorConfig.success),
          ),),
        content: Text("Please select your delivering address first ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w400,

              color: Colors.black
          ),),
        elevation: 0,
        actions: [
          ElevatedButton(

              onPressed: () {

                // Navigator.pop(context);

                Navigator.pop(context);
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
                  Text("Comfirm",style: TextStyle(
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
    var cart = widget.cartitem;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(

        title: Text('Check Out',style: TextStyle(
            color: Colors.white
        ),),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.black,
        elevation: 0,


      ),
      body: BlocConsumer<OrderBloc, OrderState>(
  listener: (context, state) {
    // TODO: implement listener
    print("State google is updated");
    print(state);
    if(state is OrderStripePending) {
      showDialog(context: context, builder: (context) {


        return  Center(

          child: CircularProgressIndicator(
            color: Color(AppColorConfig.bgcolor),

          ),
        );

      },);
      List<Productss>? item =[];

      for(int index=0;index<cart!.length;index++) {
        // print(cart[index].sizeid);
        // print(cart[index].colorid.id);
        item.add(Productss(
          id: cart![index].productid,
          quantity:  cart![index].qty,
          colorselection: cart![index].colorid.id,
          size:  cart![index].sizeid,




        ));
      }
      OrderRequestV2 order = OrderRequestV2(

          customer:widget.uid,

          method:
          "online" ,

          productss:item

      );

      BlocProvider.of<OrderBloc>(context,listen: false).add(PostOrderEvent( addressid:addressid ,orderRequestV2: order));
    }
  },
  builder: (context, state) {
    if(state is OrderLoading) {
      return Text('');
    }
    if(state is OrderSuccessCompleted) {
      print("Success");
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Success(order: state?.orderReponse,)));
      });
      //TODO use this whenever u want to push neww screen after state updated
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //   return Success();
      // },));
    }
    if(state is OrderError) {
      return Center(
        child: Text("Error has been occur"),
      );
    }
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5,left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Free Shipping",style: TextStyle(
                //   fontSize: 12.8,
                //   fontWeight: FontWeight.w500,
                //   color: Color(AppColorConfig.success)
                // ),),
                SizedBox(height: 20,),
                //TODO list product
                LimitedBox(
                  maxHeight: double.maxFinite,

                  child: ListView.builder(
                    shrinkWrap: true,


                    itemCount:cart?.length ?? 0,

                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Color colorcode = HexColor(cart?[index].colorid.code);
                      // print(colorcode);
                      // print(cart?.length);
                  return Container(

                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(

                    ),


                    child: ListTile(
                      onTap: () {

                      },


                      contentPadding: EdgeInsets.all(0),
                      leading: Image.network('${cart![index].imgurl}'

                      ,fit: BoxFit.contain,
                        width: 100,
                        height:100,
                      ),

                      title: Text('${cart![index].producttitle}',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,

                      ),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Size: ${cart[index].sizetext} ', style: TextStyle(
                                fontSize: 11.8,

                              ),),
                              Text('Color:  ', style: TextStyle(
                                fontSize: 11.8,

                              ),),
                              Container(
                                width: 12.5,
                                margin: EdgeInsets.only(right: 5),
                                height: 12.5,
                                // child: Text(attri?.colorid[index].code),
                                decoration: BoxDecoration(
                                    color:colorcode,

                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)
                                    ),


                                ),

                              ),
                              Text('\ Total: \$ ${ (cart[index].price * (cart[index].qty)).toStringAsFixed(2)}',

                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppColorConfig.success)
                              ),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(


                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,

                              children: [
                                Text('\$ ${cart[index].price.toStringAsFixed(2)}',style: TextStyle(
                                    fontSize: 18.9,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppColorConfig.success)
                                ),),
                                // Text('\ Total:  \$ ${ (cart[index].price * (cart[index].qty)).toStringAsFixed(2)}',style: TextStyle(
                                //     fontSize: 12.5,
                                //     fontWeight: FontWeight.w500,
                                //     color: Color(AppColorConfig.success)
                                // ),),
                                // Container(
                                //   padding: EdgeInsets.only(left: 15,right: 15),
                                //
                                //   decoration: BoxDecoration(
                                //     color: Color(AppColorConfig.primarylight),
                                //     borderRadius: BorderRadius.circular(25),
                                //
                                //
                                //
                                //   ),
                                //   child: Row(
                                //     children: [
                                //
                                //
                                //       SizedBox(width: 16,),
                                //       Text('${cart[index].qty}',style: TextStyle(
                                //           fontSize: 18,
                                //           color: Colors.black
                                //       ),),
                                //       SizedBox(width: 16,),
                                //
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),

                        ],
                      ),


                      // subtitle: Text('\$  ${cart![index].price}',style: TextStyle(
                      //     fontSize: 16.8,
                      //     fontWeight: FontWeight.w500,
                      //   color: Color(0xff508A7B)
                      // ),),
                      trailing: Text('Qty: x ${cart![index].qty}',style: TextStyle(
                          fontSize: 12.8,
                          color: Colors.black
                      ),),

                    ),
                  );
                  },),
                ),

                //TODO order detail
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("Delivery Address",style: TextStyle(

                          fontSize: 18,
                        ),),
                        // InkWell(
                        //   onTap: () async {
                        //     var location = await Location().getLocation();
                        //     print("User current location");
                        //     print(location.longitude);
                        //     print(location.latitude);
                        //
                        //
                        //     address = await Navigator.push(
                        //         context, MaterialPageRoute(builder: (context) {
                        //       return GoogleMapScreen(positionlong: location.longitude,
                        //         positionlat: location.latitude,
                        //       );
                        //     },));
                        //
                        //     setState(() {
                        //       print("Got Address back");
                        //       print(address);
                        //     });
                        //   },
                        //
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.add_circle_rounded),
                        //       SizedBox(width: 7,),
                        //       Text("Add new Address ", style: TextStyle(
                        //
                        //         fontSize: 12.8,
                        //
                        //       ),),
                        //     ],
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //
                        //   },
                        //   child: InkWell(
                        //       onTap: () async {
                        //         var location = await Location().getLocation();
                        //         print("User current location");
                        //         print(location.longitude);
                        //         print(location.latitude);
                        //
                        //
                        //         address = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //             return GoogleMapScreen(positionlong:     location.longitude,
                        //                 positionlat:    location.latitude,
                        //                 );
                        //
                        //         },));
                        //
                        //         setState(() {
                        //           print("Got Address back");
                        //           print(address);
                        //         });
                        //
                        //
                        //       },
                        //       child: Text('Add New',style: TextStyle(
                        //         fontSize: 11
                        //       ),)),
                        // )
                      ],
                    ),

                    SizedBox(height: 30,),
                    //TODO address

        //           Container(
        //      width: double.maxFinite,
        //      padding: EdgeInsets.only(top: 35,bottom: 35,left: 15,right: 15),
        //
        //     child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text('My Home address',style: TextStyle(
        //           fontSize: 14,
        //           fontWeight: FontWeight.w500
        //       ),),
        //
        //       address?["homeadd"] == null ?
        //       Text('${ "No address"}',style: TextStyle(
        //           fontSize: 12.8,
        //           color: Colors.grey
        //       ),) :
        //       Text('${  address?["homeadd"]}',style: TextStyle(
        //           fontSize: 12.8,
        //           color: Colors.grey
        //       ),)
        //
        //
        //     ],
        //   ),
        //   decoration: BoxDecoration(
        //       color: Color(0xffF5F5F5)
        //   ),
        // ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.2)
                    )
                ),
                height:


                300,

                child: BlocConsumer<AddressBloc, AddressState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    print("The State of Address is ${state}");
                    if(state is AddressPostDone) {
                      print("THe address is done");

                      // Future.delayed(Duration(seconds: 2),() => Navigator.pop(context),);
                      context.read<AddressBloc>().add(FetchAddress(userid: widget.uid));

                    }
                  },
                  builder: (context, state) {

                    if(state is AddressLoading) {
                      return Center(
                        child:LoadingIcon()
                      );

                    }
                    if(state is AddressError) {
                      return Center(
                        child: CircularProgressIndicator(

                        ),
                      );
                    }
                    if(state is AddressDone) {
                      print("Address Done");
                      print(  state.add?.results?.length );
                      var len =  state.add?.results?.length;
                      print(len);
                      var previewimages;

                      if( state.add?.results!.length != 0 ) {

                        if(add == null) {
                          previewimages =  LocationHelper.staticmapurl(latitute:
                          double.parse( state.add!.results![len!-1].latitude!),longtitute:

                          double.parse( state.add!.results![len!-1].longitude!)

                          );
                        }
                        else {
                          previewimages =  LocationHelper.staticmapurl(latitute:
                          double.parse(add['latitute']),longtitute:

                          double.parse( add['longtitute']!)

                          );
                        }


                      }

                      return     state.add?.results?.length  == 0?


                      Container(
                        width: double.maxFinite,


                        margin: EdgeInsets.only(bottom: 10,right: 10),

                        padding: EdgeInsets.only(
                            top: 0, bottom: 35, left: 0, right: 0),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(

                              padding:EdgeInsets.all(10) ,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(

                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,color: Colors.white,size: 20,),
                                        Text("Current Location",style: TextStyle(
                                            fontSize: 12.8
                                            ,color: Colors.white
                                        ),)
                                      ],
                                    ),
                                    onTap: () async {

                                      showDialog(context: context, builder: (context) {


                                        return  Center(

                                          child: CircularProgressIndicator(
                                            color: Color(AppColorConfig.bgcolor),

                                          ),
                                        );

                                      },);
                                      Future.delayed(Duration(seconds: 2),() => Navigator.pop(context),);
                                      print("On Tap called");
                                      print("Tap");


                                      var location = await Location().getLocation();
                                      print(location.latitude);
                                      print(location.longitude);
                                      SendLatandLong(location.latitude,location.longitude);
                                      print("Get Location latitute and longitutee");
                                      print(mapofaddress);

                                      setState(() {
                                        // if(mapofaddress!=null || mapofaddress != '') {
                                        //   print("Send here");
                                        //   BlocProvider.of<AddressBloc>(context, listen: false)
                                        //       .add(PostAddress(
                                        //       add: AddressBody(
                                        //         city: city,
                                        //         country: country,
                                        //         lat:lat,
                                        //         lon: long,
                                        //         street: homeadd,
                                        //
                                        //
                                        //
                                        //       ),
                                        //       userid: userid,
                                        //       desc: txtdesc.text
                                        //   ));
                                        // }
                                      });

                                    },
                                  ),
                                  InkWell(


                                    child: Row(
                                      children: [
                                        Icon(Icons.map
                                            ,color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Select On Map",style: TextStyle(
                                            fontSize: 12.8
                                            ,color: Colors.white
                                        ),)
                                      ],
                                    ),
                                    onTap: () async {


                                      var location = await Location().getLocation();
                                      print("User current location");
                                      print(location.longitude);
                                      print(location.latitude);



                                      address = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return GoogleMapScreen(positionlong:     location.longitude,
                                          positionlat:    location.latitude,
                                        );

                                      },));

                                      setState(() {
                                        print("Got Address back");
                                        print(address);
                                        // Navigator.pop(context);
                                      });

                                    },
                                  )

                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(AppColorConfig.success)
                              ),
                              width: double.maxFinite,
                            ),

                            Center(child:

                            InkWell(

                              child: Container(

                                child: Lottie.asset('assets/logo/Animation - 1698223136592.json',
                                fit: BoxFit.cover
                                ),
                                height: 178,

                              ),
                              onTap: () async {
                                var location = await Location().getLocation();
                                print("User current location");
                                print(location.longitude);
                                print(location.latitude);


                                address = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return GoogleMapScreen(positionlong:     location.longitude,
                                    positionlat:    location.latitude,
                                  );

                                },));

                                setState(() {
                                  print("Got Address back");
                                  print(address);
                                });
                              },
                            )

                            ),



                            SizedBox(height: 15,),




                          ],
                        ),
                        // decoration: BoxDecoration(
                        //     // color: Colors.white,
                        //     border: Border.all(
                        //         // color: Colors.grey.withOpacity(0.2)
                        //     )
                        // ),
                      )  :
                     ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:  state.add?.results!.length  ?? 0  ,

                        itemBuilder: (context, index) {
                          if(add == null ) {
                            addressid =   state.add?.results?[len!-1].id;
                          }
                          else {
                            addressid =   add['addressid'];
                          }

                          return


                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndexAddress = index;

                                });
                                print("Selected addr index");
                                print(selectedIndexAddress);
                              },
                              child: Container(
                                width: double.maxFinite,


                                margin: EdgeInsets.only(bottom: 10,right: 10),

                                padding: EdgeInsets.only(
                                    top: 25, bottom: 35, left: 15, right: 15),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [


                                            InkWell(
                                              onTap: () async {
                                                // InkWell(
                                                //   onTap: () {
                                                //
                                                //   },
                                                //   child: InkWell(
                                                //       onTap: () async {
                                                // var location = await Location().getLocation();
                                                // print("User current location");
                                                // print(location.longitude);
                                                // print(location.latitude);
                                                //
                                                //
                                                // address = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                //   return GoogleMapScreen(positionlong:     location.longitude,
                                                //     positionlat:    location.latitude,
                                                //   );
                                                //
                                                // },));
                                                //
                                                // setState(() {
                                                //   print("Got Address back");
                                                //   print(address);
                                                // });
                                                //
                                                //
                                                //       },
                                                //       child: Text('Add New',style: TextStyle(
                                                //         fontSize: 11
                                                //       ),)),
                                                // )
                                           //TODO choose location here
                                           //
                                           //      showDialog(context: context, builder: (context) {
                                           //
                                           //
                                           //        return  Center(
                                           //
                                           //          child: CircularProgressIndicator(
                                           //            color: Color(AppColorConfig.bgcolor),
                                           //
                                           //          ),
                                           //        );
                                           //
                                           //      },);
                                           //      Future.delayed(Duration(seconds: 2),() => Navigator.pop(context),);

                                                add =   await Navigator.push(
                                                    context, MaterialPageRoute(builder: (context) {

                                                  return AddressProductScr(
                                                    ischoice: true  ,
                                                    userid:    widget.uid ,

                                                  );
                                                },));

                                             setState(() {
                                               print("Got Address id: ");
                                               print(add);

                                               print("Click location");
                                               print(add['latitute']);
                                               print(add['longtitute']);
                                               // SendLatandLong(  double.parse(add['latitute']),   double.parse(add['longtitute']));

                                               addressid = add['addressid'];
                                               print("The location is ${addressid}");
                                             });

                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.location_on),
                                                  Text("Choose Locations",style: TextStyle(
                                                    fontSize: 12.8
                                                  ),)
                                                ],
                                              ),
                                            ),




                                          InkWell(


                                            child: Row(
                                              children: [
                                                Icon(Icons.map),
                                                Text("Select On Map",style: TextStyle(
                                                    fontSize: 12.8
                                                ),)
                                              ],
                                            ),
                                            onTap: () async {
                                              // InkWell(
                                              //   onTap: () {
                                              //
                                              //   },
                                              //   child: InkWell(
                                              //       onTap: () async {




                                                      var location = await Location().getLocation();

                                                      print("User current location");
                                                      print(location.longitude);
                                                      print(location.latitude);


                                                      address = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return GoogleMapScreen(positionlong:     location.longitude,
                                                              positionlat:    location.latitude,
                                                              );

                                                      },));

                                                      setState(() {
                                                        print("Got Address back");
                                                        print(address);

                                                      });
                                              //
                                              //
                                              //       },
                                              //       child: Text('Add New',style: TextStyle(
                                              //         fontSize: 11
                                              //       ),)),
                                              // )
                                            },
                                          )

                                        ],
                                      ),


                                    SizedBox(height: 15,),
                                    if(previewimages != null )
                                    Image.network('${previewimages}',fit: BoxFit.cover,

                                      width: double.maxFinite,
                                      height: 180,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [


                                        // Text('${
                                        //     selectedIndexAddress == index ?
                                        //         'Selected Address' :
                                        //     state.add?.results![index].description
                                        //
                                        //
                                        // }', style: TextStyle(
                                        //     fontSize: 16,
                                        //     fontWeight: FontWeight.w500
                                        // ),),



                                        // InkWell(
                                        //   onTap: () {
                                        //
                                        //   },
                                        //   child: InkWell(
                                        //       onTap: () async {
                                        //         var location = await Location()
                                        //             .getLocation();
                                        //         print("User current location");
                                        //         print(location.longitude);
                                        //         print(location.latitude);
                                        //
                                        //
                                        //         address = await Navigator.push(context,
                                        //             MaterialPageRoute(
                                        //               builder: (context) {
                                        //                 return GoogleMapScreen(
                                        //                   positionlong: location
                                        //                       .longitude,
                                        //                   positionlat: location
                                        //                       .latitude,
                                        //                 );
                                        //               },));
                                        //
                                        //         setState(() {
                                        //           print("Got Address back");
                                        //           print(address);
                                        //         });
                                        //       },
                                        //       child: Text('Edit', style: TextStyle(
                                        //           fontSize: 10.8,
                                        //         color: Color(AppColorConfig.success)
                                        //       ),)),
                                        // )
                                      ],
                                    ),

                                    SizedBox(height: 10,),

                                    Text('${
                                        add == null ?

                                        state.add?.results![len!-1].street :
                                        add['street']

                                    }', style: TextStyle(
                                        fontSize: 14.8,
                                        color: Colors.black
                                    ),)


                                  ],
                                ),
                                // decoration: BoxDecoration(
                                //   color: Colors.white,
                                //   border: Border.all(
                                //     color: Colors.grey.withOpacity(0.2)
                                //   )
                                // ),
                              ),
                            );
                        },);
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(

                        ),
                      );
                    }
                  },
                ),
              )   ,
                    //TODO Payment
                    SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment Method",style: TextStyle(

                          fontSize: 16,
                        ),),

                      ],
                    ),
                    SizedBox(height: 20,),

                    //TODO payment type



                    ListTile(
                      style: ListTileStyle.list,
                      onTap: () {
                        setState(() {
                          initpayment = 0;
                          print(initpayment);

                        });
                      },
                      selected: initpayment == 1 ,
                      // selectedTileColor: Color(AppColorConfig.primaryswatch),
                      tileColor: Color(AppColorConfig.primarylight),
                      shape: Border.all(
                          color: Colors.grey.withOpacity(0.25)
                      ),
                      contentPadding: EdgeInsets.all(10),

                      leading:           Image.asset('assets/logo/Money icon.png',

                        width: 50,
                        height: 50,
                      ),
                      title: Text("Cash on Delivery",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),),
                      subtitle: Text("Pay when product arrive",style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.8,
                          fontWeight: FontWeight.w400

                      ),),
                    ),
                    SizedBox(height: 10,),
                    ListTile(
                      style: ListTileStyle.list,
                      onTap: () {
                        setState(() {
                          initpayment = 1;
                          print(initpayment);

                        });
                      },
                      selected: initpayment == 1 ,

                      selectedTileColor: Color(AppColorConfig.primarylight),
                      // tileColor: Color(AppColorConfig.primarylight),
                      shape: Border.all(
                          color: Colors.grey.withOpacity(0.25)
                      ),
                      contentPadding: EdgeInsets.all(10),

                      leading:      Image.asset('assets/logo/Credit Card Icon.png',

                        width: 50,
                        height: 50,
                        color: Colors.black,
                        // color:
                        //
                        //
                        // initpayment == 1?
                        // Colors.white:
                        // Colors.black,

                      ),
                      title: Text("Credit or Debit Card",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),),
                      subtitle: Text("Visa or Mastercard",style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.8,
                          fontWeight: FontWeight.w400

                      ),),
                    ),
                    SizedBox(height: 20,),


                //     Container(
                //       padding: EdgeInsets.only(left: 15,top: 10,bottom: 30),
                //       margin: EdgeInsets.only(top: 5),
                //
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // Text("Please select your method of payment",style: TextStyle(
                //           //
                //           //   fontSize: 12.8,
                //           // ),),
                //           SizedBox(height: 20,),
                //
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //
                //             children: [
                //
                // //TODO by Cash
                //               InkWell(
                //                 onTap: () {
                //                   setState(() {
                //                     initpayment  = 0;
                //
                //                   });
                //                 },
                //                 child: Container(
                //
                //                   decoration: BoxDecoration(
                //                     color:
                //
                //                     selectedmethod == initpayment?
                //                         Color(AppColorConfig.success) :
                //                     Colors.white,
                //                     borderRadius: BorderRadius.circular(10)
                //                   ),
                //                   alignment: Alignment.center,
                //                   width: 121.08,
                //                   height: 89,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Image.asset('assets/logo/Money icon.png',
                //
                //                       width: 50,
                //                           height: 50,
                //                       ),
                //                       Text('Cash',style: TextStyle(
                //                         color:
                //                         initpayment == 0?
                //                         Colors.white :
                //
                //                           Color(AppColorConfig.success)
                //                       ),)
                //
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(width: 10,),
                //               //TODO by payment method
                //               InkWell(
                //                 onTap: () {
                //                   setState(() {
                //                     initpayment = 1;
                //
                //                   });
                //                 },
                //                 child: Container(
                //
                //                   decoration: BoxDecoration(
                //                       color:
                //                       initpayment == 1?
                //                       Color(AppColorConfig.success) :
                //                       Colors.white,
                //                       borderRadius: BorderRadius.circular(10)
                //                   ),
                //                   alignment: Alignment.center,
                //                   width: 121.08,
                //                   height: 89,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Image.asset('assets/logo/Credit Card Icon.png',
                //
                //                         width: 50,
                //                         height: 50,
                //                       color:
                //
                //
                //                       initpayment == 1?
                //                       Colors.white:
                //                       Colors.black,
                //
                //                       ),
                //                       Text('MasterCard ',style: TextStyle(
                //                         color:
                //                         initpayment == 1?
                //                         Colors.white:
                //                         Colors.black,
                //
                //
                //                       ),)
                //
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       decoration: BoxDecoration(
                //           color: Color(0xffF5F5F5)
                //       ),
                //     ),
                    SizedBox(height: 40,),
                    //TODO Product Details

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Product Detail",style: TextStyle(

                          fontSize: 16,
                        ),),



                      ],
                    ),
                    Divider(),

                    //TODO product row

                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15,top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Product Qty',style: TextStyle(
                                color: Colors.grey
                              ),),
                              Text('x ${widget.qtytotal}',style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total ',style: TextStyle(

                                  color: Colors.grey
                              ),),
                              Text('\$ ${widget.subtotal}',style: TextStyle(
                                  // color: Color(AppColorConfig.success),
                                  // fontSize: 18,
                                  // fontWeight: FontWeight.w500
                                // fontWeight: FontWeight.w500,
                                // color: Color(AppColorConfig.success),
                                // fontSize: 18,
                              ),),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 15),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text('Promotion Discount',style: TextStyle(
                        //           color: Colors.grey
                        //       ),),
                        //       Text(' % ${widget?.discount ?? 0}'),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Fees', style: TextStyle(

                                color: Colors.grey
                            ),),
                            Text(' FREE ', style: TextStyle(

                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),)
                          ],
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(bottom: 135,top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xffC2E5DF)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('SubTotal',style: TextStyle(
                                  color: Color(AppColorConfig.success),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              ),),
                              Text('\$ ${widget.subtotal}',style: TextStyle(
                                  color: Color(AppColorConfig.success),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ),

              ],
            ),

          )
        ),
      );
  },
),
      bottomNavigationBar:  BlocConsumer<OrderBloc, OrderState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    if(state is OrderLoading) {
      return Text('');
    }
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(

          children: [
            Expanded(
              child: FloatingActionButton.extended(
                  backgroundColor: Color(AppColorConfig.success),

                  elevation: 0,
                  
                  isExtended: true,

                  extendedPadding: EdgeInsets.all(0),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  //
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(14)
                  // ),
                  onPressed: () {
                    //TODO submit order
                    print("Submit Order");
                    print("USer address id is ${addressid}");

                    if(addressid == null ) {
                      print("True True");
                      PopUpUnauthorize(context);
                      return ;
                    }
                    //TODO do some event

                    showDialog(context: context, builder: (context) {


                      return  Center(

                        child: CircularProgressIndicator(
                          color: Color(AppColorConfig.bgcolor),

                        ),
                      );

                    },);
                    List<Productss>? item =[];


                    for(int index=0;index<cart!.length;index++) {

                      print( cart![index].colorid.id,);
                      item.add(Productss(
                        id: cart![index].productid,
                        quantity:  cart![index].qty,

                        colorselection: cart![index].colorid.id,
                        size:  cart![index].sizeid,



                      ));
                    }
                    print("Error");

                    print("Item in cart");
                    print(item.length);
                    //TODO orderrequest
                    print(item);



                    print(widget.uid);
                    print(initpayment);
                    print("SAda");


                    if(initpayment == 1) {
                      print("What is our init state");
                      double total = 0;
                      var qtytotal = 0;
                      cart!?.forEach((element) {
                        print(element.price);
                        total += (element!.price * element.qty);
                        qtytotal += element!.qty!;

                      });
                      //TODO stripe payment function
                      makePayment(currency:"USD",totalamount:total.ceil().toString()).then((value) {
                        print("Success");



                      }).catchError((err) {
                        print(err);

                      });

                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return TestScreen(currency: 'USD',total: total.ceil(),);
                      // },));

                    }
                    //

                    else{
                      print(item[0].colorselection);
                      print(item[0].quantity);

                      OrderRequestV2 order = OrderRequestV2(

                          customer:widget.uid,


                          method:
                          initpayment == 0?
                          "Cash" :
                          "online",


                          productss:item

                      );

                      BlocProvider.of<OrderBloc>(context,listen: false).add(PostOrderEvent(
                          addressid:addressid ,orderRequestV2:
                      order));
                    }



                  }, label:Text('Place Order',style: TextStyle(
                  fontSize: 15.8
              ),)),
            ),
          ],
        ),
      );
  },
),



    );
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var res = await http.
      post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization': 'Bearer ${StripeService.clientkey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body
      );
      print("Payment body: ${res.body.toString()}");
      return json.decode(res.body);
    } catch (error) {
      print('  createPaymentIntentresponse error');
      print(error.toString());
    }
  }

  String calculateAmount(String amount) {
    return ((int.parse(amount)) * 100).toString();
  }

  Future<void> makePayment({totalamount,currency}) async {
    print("payment");
    try {
      paymentintent = await createPaymentIntent(totalamount.toString(), 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentintent!['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: 'Adnan')).then((value) {
        displayPaymentSheet();

      });
      // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
      // googlePay: const PaymentSheetGooglePay(merchantCountryCode: )
      //after successfully paid
      Navigator.pop(context);
    } catch (err) {
      print('send response error');
      print(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(

      ).then((value) {

        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Payment Successfully'),
          );
        },);
        paymentintent = null;
        context.read<OrderBloc>().add(OrderStripe());
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    } on StripeException catch (e) {
      print("Stripe error catching ${e}");
      await Stripe.instance.presentPaymentSheet(

      ).then((value) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Error has been occur'),
          );
        },);
        paymentintent = null;
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    }
  }
}


