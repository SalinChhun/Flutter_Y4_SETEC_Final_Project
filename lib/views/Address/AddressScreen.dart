import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/products/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:ecommerce/helper/GoogleLocation.dart';
import '../../service/GoogleMap/GoogleMapScreen.dart';
import '../widget/LoadingIcon.dart';

class AddressProductScr extends StatefulWidget {
  dynamic ischoice;

  AddressProductScr({Key? key, this.ischoice}) : super(key: key);

  @override
  State<AddressProductScr> createState() => _AddressProductScrState();
}

class _AddressProductScrState extends State<AddressProductScr> {
  dynamic userId;
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
  var iserrordesc = true;
  var txtdesc = TextEditingController();
  var formdesc = GlobalKey<FormState>();
  LocationHelper locationhelper = LocationHelper();

  @override
  void initState() {
    super.initState();
  }

  void getUserSharePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userId != null) {
      userId = prefs.getInt("userid");
      // Fetch addresses when the screen initializes
      BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid: userId));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Address', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
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
              SizedBox(height: 7),
              InkWell(
                onTap: () async {
                  var location = await Location().getLocation();
                  address = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GoogleMapScreen(
                          positionlong: location.longitude,
                          positionlat: location.latitude,
                        );
                      },
                    ),
                  );

                  if (address != null) {
                    // If an address was returned, update the state
                    setState(() {
                      print("Got Address back");
                      print(address);
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.add_circle_rounded),
                    SizedBox(width: 7),
                    Text("Add new Address", style: TextStyle(fontSize: 12.8)),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 10),
              Expanded(
                child: BlocConsumer<AddressBloc, AddressState>(
                  listener: (context, state) {
                    if (state is AddressPostDone) {
                      // Fetch addresses after adding or updating
                      context.read<AddressBloc>().add(FetchAddress(userid: userId));
                    }
                  },
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return LoadingIcon();
                    }
                    if (state is AddressError) {
                      return LoadingIcon();
                    }
                    if (state is AddressDone) {
                      return state.add?.results?.isEmpty ?? true
                          ? Center(child: Lottie.asset('assets/logo/Animation - 1698223136592.json'))
                          : ListView.builder(
                              itemCount: state.add ?.results?.length ?? 0,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Map<String, dynamic> add = {
                                      "latitude": state.add?.results![index].latitude,
                                      "longitude": state.add?.results![index].longitude,
                                      "addressid": state.add?.results![index].id,
                                      "street": state.add?.results![index].street,
                                    };
                                    Navigator.pop(context, add);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(112, 16, 223, 100).withOpacity(0.4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.location_on, size: 35, color: Color(AppColorConfig.primarycolor)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${state.add?.results![index].description}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(AppColorConfig.primarycolor),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '${state.add?.results![index].street}',
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: 12.8,
                                                      color: Color(AppColorConfig.primarycolor),
                                                    ),
                                                  ),
                                                  width: 220,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                var location = await Location().getLocation();
                                                address = await Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return GoogleMapScreen(
                                                      positionlong: location.longitude,
                                                      positionlat: location.latitude,
                                                      isupdate: true,
                                                      addid: state.add?.results![index].id,
                                                      label: state.add?.results![index].description,
                                                    );
                                                  },
                                                ));
                                                setState(() {
                                                  print("Got Address back");
                                                  print(address);
                                                });
                                              },
                                              child: Icon(Icons.edit, color: Color(AppColorConfig.primarycolor)),
                                            ),
                                            SizedBox(width: 5),
                                            InkWell(
                                              onTap: () {
                                                context.read<AddressBloc>().add(DeleteAddress(id: state.add?.results![index].id));
                                              },
                                              child: Icon(Icons.delete, color: Colors.red.shade700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    } else {
                      return LoadingIcon();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}