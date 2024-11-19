import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/products/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import 'package:lottie/lottie.dart';
import 'package:ecommerce/helper/GoogleLocation.dart';
import '../../service/GoogleMap/GoogleMapScreen.dart';
import '../widget/LoadingIcon.dart';

class AddressProductScr extends StatefulWidget {
  var userid;
  var ischoice;
  AddressProductScr({Key? key,this.userid,this.ischoice}) : super(key: key);

  @override
  State<AddressProductScr> createState() => _AddressProductScrState();
}

class _AddressProductScrState extends State<AddressProductScr> {
  var address;
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
  LocationHelper locationhelper = LocationHelper();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print(widget.userid);


  }

  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid: widget.userid));
    print("State updated");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text('Address', style: TextStyle(
            color: Colors.black
        ),),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 7,),
              InkWell(
                onTap: () async {
                  showDialog(context: context, builder: (context) {


                    return  Center(

                      child: CircularProgressIndicator(
                        color: Color(AppColorConfig.bgcolor),

                      ),
                    );

                  },);
                  var location = await Location().getLocation();
                  print("User current location");
                  print(location.longitude);
                  print(location.latitude);
                  showDialog(context: context, builder: (context) {


                    return  Center(

                      child: CircularProgressIndicator(
                        color: Color(AppColorConfig.bgcolor),

                      ),
                    );

                  },);


                  address = await Navigator.push(
                      context, MaterialPageRoute(builder: (context) {
                    return GoogleMapScreen(positionlong: location.longitude,
                      positionlat: location.latitude,
                    );
                  },));

                  setState(() {
                    Navigator.pop(context);
                    print("Got Address back");
                    print(address);
                    Navigator.pop(context);
                  });
                },

                child: Row(
                  children: [
                    Icon(Icons.add_circle_rounded),
                    SizedBox(width: 7,),
                    Text("Add new Address ", style: TextStyle(

                      fontSize: 12.8,

                    ),),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 10,),
              //TODO address
              Expanded(child:
              BlocConsumer<AddressBloc, AddressState>(
                listener: (context, state) {
                  print(state);
                  // TODO: implement listener
                  if(state is AddressPostDone) {
                   context.read<AddressBloc>().add(FetchAddress(userid: widget.userid));
                  }
                },
                builder: (context, state) {
                  if(state is AddressLoading) {
                    return LoadingIcon();

                  }
                  if(state is AddressError) {
                    return LoadingIcon();
                  }
                  if(state is AddressDone) {
                    print(    state.add?.results?.length);



                    return
                      state.add?.results?.length == 0 ?
                      Center(
                        child: Lottie.asset('assets/logo/Animation - 1698223136592.json')

                        ,) :

                      ListView.builder(
                      itemCount: state.add?.results?.length ?? 0,

                      itemBuilder: (context, index) {
                        return

                          InkWell(
                            onTap: () {
                              // print(index);
                              print( state.add?.results![index].id);
                              Map<String,dynamic> add =  {

                                "latitute":state.add?.results![index].latitude,
                                "longtitute":state.add?.results![index].longitude,
                                "addressid":state.add?.results![index].id,
                                "street":state.add?.results![index].street
                              };
                              Navigator.pop(context,add);

                            },
                            child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(bottom: 10),

                            padding: EdgeInsets.only(
                                top: 35, bottom: 35, left: 15, right: 15),
                            decoration: BoxDecoration(
                                color: Color(AppColorConfig.primarylight)
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Icon(Icons.location_on,size:35,color: Color(AppColorConfig.success),),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text('${state.add?.results![index].description}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,

                                      style: TextStyle(
                                        fontSize: 16,

                                        color: Color(AppColorConfig.success),
                                        fontWeight: FontWeight.w600,


                                    ),

                                    ),


                                    Row(
                                      children: [
                                        Container(

                                          child: Text('${state.add?.results![index].street}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: true  ,

                                            style: TextStyle(
                                              fontSize: 12.8,
                                              overflow: TextOverflow.ellipsis,
                                            color: Color(AppColorConfig.success),
                                          ),),
                                          width: 220,
                                        ),
                                      ],
                                    )


                                  ],
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: InkWell(
                                          onTap: () async {
                                            var location = await Location()
                                                .getLocation();
                                            print("User current location");
                                            print(location.longitude);
                                            print(location.latitude);


                                            address = await Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return GoogleMapScreen(
                                                      positionlong: location
                                                          .longitude,
                                                      positionlat: location
                                                          .latitude,
                                                      isupdate: true,
                                                      addid:state.add?.results![index].id ,
                                                      label:state.add?.results![index].description ,

                                                    );
                                                  },));

                                            setState(() {
                                              print("Got Address back");
                                              print(address);
                                            });
                                          },
                                          child: Icon(Icons.edit,color: Color(AppColorConfig.success),)),
                                    ),
                                    SizedBox(width: 5,),

                                    InkWell(
                                      onTap: () {
                                        print(state.add?.results![index].id);
                                        context.read<AddressBloc>()
                                            .add(DeleteAddress(id: state.add?.results![index].id));

                                      },
                                      child: InkWell(

                                          child: Icon(Icons.delete,color: Colors.red.shade700,)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                        ),
                          );
                      },);
                  }
                  else{
                    return LoadingIcon();
                  }
                },
              ))


              //TODO Payment


              //TODO product row

            ],
          ),
        ),
      ),


    );
  }

// PopUpColor(BuildContext context) {
//   showDialog(context: context, builder: (context) {
//     return AlertDialog(
//       content: Column(
//         children: [
//           Text('Choose Color'),
//           CheckboxListTile(
//             title: Text('Red'),
//             value: _isChecked ,
//             onChanged: (value) {
//               setState(() {
//
//                 _isChecked = value!;
//
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   },);
//
//
// }
}
