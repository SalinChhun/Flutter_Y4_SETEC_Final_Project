import 'package:ecommerce/helper/GoogleLocation.dart';
import 'package:ecommerce/model/Address.dart';
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/service/GoogleMap/GoogleMapScreen.dart';
import 'package:ecommerce/viewmodel/products/address_bloc.dart';
import 'package:ecommerce/views/Address/AddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../widget/LoadingIcon.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/LoadingIcon.dart';

class DeliveryAddress extends StatefulWidget {
  final Function(int?)? onAddressSelected;

  const DeliveryAddress({
    super.key,
    this.onAddressSelected,
  });

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  dynamic userId;
  final LocationHelper _locationHelper = LocationHelper();
  final TextEditingController _descriptionController = TextEditingController();

  Map<String, dynamic>? _selectedAddress;
  int? _selectedAddressIndex;

  @override
  void initState() {
    super.initState();
    getUserSharePrefs();
  }

  void getUserSharePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userId != null) {
      userId = prefs.getInt("userid");
      _fetchAddresses();
    }
  }

  void _fetchAddresses() {
    BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid: userId));
  }

  Future<void> _getCurrentLocationAndSave() async {
    try {
      _showLoadingDialog();

      var location = await Location().getLocation();

      var mapOfAddress = await _locationHelper.getPlaceWithLatLng(
          location.latitude!, location.longitude!);

      if (mapOfAddress != null && mapOfAddress.isNotEmpty) {
        String? homeAddress = mapOfAddress[0]['formatted_address'];
        String? country = mapOfAddress[0]["address_components"][6]["long_name"];
        String? city = mapOfAddress[5]["address_components"][5]["long_name"];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        BlocProvider.of<AddressBloc>(context).add(
          PostAddress(
            add: AddressBody(
              city: city,
              country: country,
              lat: location.latitude,
              lon: location.longitude,
              street: homeAddress,
            ),
            userid: prefs.getInt('userid'),
            desc: _descriptionController.text,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Color(AppColorConfig.bgcolor),
        ),
      ),
    );
  }

  Widget _buildNoAddressContent() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLocationActionBar(),
          Center(
            child: InkWell(
              onTap: _openGoogleMaps,
              child: Container(
                height: 178,
                child: Lottie.asset(
                  'assets/logo/Animation - 1698223136592.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildLocationActionBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(AppColorConfig.primarycolor),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLocationButton(
            icon: Icons.location_on,
            label: "Current Location",
            onTap: _getCurrentLocationAndSave,
          ),
          _buildLocationButton(
            icon: Icons.map,
            label: "Update Location",
            onTap: () async {

              await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  getUserSharePrefs();
                  return AddressProductScr(
                      ischoice: true,
                  );
                },
              ));

              setState(() {
                // print(address);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.8,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openGoogleMaps() async {
    var location = await Location().getLocation();

    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => GoogleMapScreen(
          positionlong: location.longitude,
          positionlat: location.latitude,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedAddress = result;
      });
    }
  }

  Widget _buildAddressListView(AddressDone state) {
    final addresses = state.add?.results ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationActionBar(),
          const SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addresses.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final address = addresses[index];
              final previewImage = LocationHelper.staticmapurl(
                latitute: double.parse(address.latitude!),
                longtitute: double.parse(address.longitude!),
              );

              return _buildAddressCard(
                address: address,
                previewImage: previewImage,
                index: index,
                isSelected: _selectedAddressIndex == index,
                onTap: () {
                  setState(() {
                    _selectedAddressIndex = index;
                    widget.onAddressSelected?.call(address.id);
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard({
    required dynamic address,
    required String? previewImage,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue.shade300 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.shade100.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Address ${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blue.shade700 : Colors.black,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            if (previewImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  previewImage,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            Text(
              address.street ?? 'No address',
              style: TextStyle(
                fontSize: 14.8,
                color: isSelected ? Colors.blue.shade900 : Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressPostDone) {
            _fetchAddresses();
          }
        },
        builder: (context, state) {
          if (state is AddressLoading) {
            return const Center(child: LoadingIcon());
          }

          if (state is AddressError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load addresses'),
                  ElevatedButton(
                    onPressed: _fetchAddresses,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AddressDone) {
            return (state.add?.results?.isEmpty ?? true)
                ? _buildNoAddressContent()
                : _buildAddressListView(state);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}



















// import 'package:ecommerce/helper/GoogleLocation.dart';
// import 'package:ecommerce/model/Address.dart';
// import 'package:ecommerce/res/constant/appcolor.dart';
// import 'package:ecommerce/service/GoogleMap/GoogleMapScreen.dart';
// import 'package:ecommerce/viewmodel/products/address_bloc.dart';
// import 'package:ecommerce/views/Address/AddressScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import '../widget/LoadingIcon.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Deliveryaddress extends StatefulWidget {
//   var uid;
//   final Function(int?)? onAddressSelected;

//   Deliveryaddress({
//     Key? key,
//     this.onAddressSelected,
//     this.uid,
//   }) : super(key: key);

//   @override
//   State<Deliveryaddress> createState() => _DeliveryAddressState();
// }

// class _DeliveryAddressState extends State<Deliveryaddress> {
//   var long;
//   var lat;
//   var mapofaddress;
//   var homeadd;
//   var city;
//   var country;
//   var add;
//   var address;
//   int? addressid;
//   var selectedIndexAddress = 0;
//   var txtdesc = TextEditingController();
  
//   LocationHelper locationhelper = LocationHelper();

//   @override
//   void initState() {
//     // TODO: implement initState
//     BlocProvider.of<AddressBloc>(context).add(FetchAddress(userid: widget.uid));
//     super.initState();
//     print("Checkout userid");
//     print('address user ${FetchAddress(userid: widget.uid)}');
//   }

//   SendLatandLong(lat, long) async {
//     mapofaddress = await locationhelper.getPlaceWithLatLng(lat, long);

//     print('call');
//     print(mapofaddress);

//     print(mapofaddress[5]["address_components"][5]["long_name"]);
//     homeadd = mapofaddress[0]['formatted_address'];
//     // print(mapofaddress[0]["address_components"][6]["long_name"]);
//     country = mapofaddress[0]["address_components"][6]["long_name"];
//     city = mapofaddress[5]["address_components"][5]["long_name"];
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     BlocProvider.of<AddressBloc>(context, listen: false).add(PostAddress(
//         add: AddressBody(
//           city: city,
//           country: country,
//           lat: lat,
//           lon: long,
//           street: homeadd,
//         ),
//         userid: prefs?.getInt('userid'),
//         desc: txtdesc.text));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.grey.withOpacity(0.2))),
//       height: 300,
//       child: BlocConsumer<AddressBloc, AddressState>(
//         listener: (context, state) {
//           // TODO: implement listener
//           print("The State of Address is ${state}");
//           if (state is AddressPostDone) {
//             print("THe address is done");
//             context.read<AddressBloc>().add(FetchAddress(userid: widget.uid));
//             widget.onAddressSelected?.call(addressid);
//           }
//         },
//         builder: (context, state) {
          
//           if (state is AddressLoading) {
//             return Center(child: LoadingIcon());
//           }
//           if (state is AddressError) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is AddressDone) {
//             print("Address Done");
//             print(state.add?.results?.length);
//             var len = state.add?.results?.length;
//             print(len);
//             var previewimages;

//             if (state.add?.results!.length != 0) {
//               if (add == null) {
//                 previewimages = LocationHelper.staticmapurl(
//                     latitute:
//                         double.parse(state.add!.results![len! - 1].latitude!),
//                     longtitute:
//                         double.parse(state.add!.results![len! - 1].longitude!));
//               } else {
//                 previewimages = LocationHelper.staticmapurl(
//                     latitute: double.parse(add['latitute']),
//                     longtitute: double.parse(add['longtitute']!));
//               }
//             }

//             return state.add?.results?.length == 0
//                 ? Container(
//                     width: double.maxFinite,
//                     margin: EdgeInsets.only(bottom: 10, right: 10),
//                     padding:
//                         EdgeInsets.only(top: 0, bottom: 35, left: 0, right: 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                     Text(
//                                       "Current Location",
//                                       style: TextStyle(
//                                           fontSize: 12.8, color: Colors.white),
//                                     )
//                                   ],
//                                 ),
//                                 onTap: () async {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return Center(
//                                         child: CircularProgressIndicator(
//                                           color: Color(AppColorConfig.bgcolor),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                   Future.delayed(
//                                     Duration(seconds: 2),
//                                     () => Navigator.pop(context),
//                                   );
//                                   print("On Tap called");
//                                   print("Tap");

//                                   var location = await Location().getLocation();
//                                   print(location.latitude);
//                                   print(location.longitude);
//                                   SendLatandLong(
//                                       location.latitude, location.longitude);
//                                   print("Get Location latitute and longitutee");
//                                   print(mapofaddress);

//                                   setState(() {});
//                                 },
//                               ),
//                               InkWell(
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.map,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Select On Map",
//                                       style: TextStyle(
//                                           fontSize: 12.8, color: Colors.white),
//                                     )
//                                   ],
//                                 ),
//                                 onTap: () async {
//                                   var location = await Location().getLocation();
//                                   print("User current location");
//                                   print(location.longitude);
//                                   print(location.latitude);

//                                   address = await Navigator.push(context,
//                                       MaterialPageRoute(
//                                     builder: (context) {
//                                       return GoogleMapScreen(
//                                         positionlong: location.longitude,
//                                         positionlat: location.latitude,
//                                       );
//                                     },
//                                   ));

//                                   setState(() {
//                                     print("Got Address back");
//                                     print(address);
//                                     // Navigator.pop(context);
//                                   });
//                                 },
//                               )
//                             ],
//                           ),
//                           decoration: BoxDecoration(
//                               color: Color(AppColorConfig.success)),
//                           width: double.maxFinite,
//                         ),
//                         Center(
//                             child: InkWell(
//                           child: Container(
//                             child: Lottie.asset(
//                                 'assets/logo/Animation - 1698223136592.json',
//                                 fit: BoxFit.cover),
//                             height: 178,
//                           ),
//                           onTap: () async {
//                             var location = await Location().getLocation();
//                             print("User current location");
//                             print(location.longitude);
//                             print(location.latitude);

//                             address =
//                                 await Navigator.push(context, MaterialPageRoute(
//                               builder: (context) {
//                                 return GoogleMapScreen(
//                                   positionlong: location.longitude,
//                                   positionlat: location.latitude,
//                                 );
//                               },
//                             ));

//                             setState(() {
//                               print("Got Address back");
//                               print(address);
//                             });
//                           },
//                         )),
//                         SizedBox(
//                           height: 15,
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: state.add?.results!.length ?? 0,
//                     itemBuilder: (context, index) {
//                       if (add == null) {
//                         addressid = state.add?.results?[len! - 1].id;
//                       } else {
//                         addressid = add['addressid'];
//                       }

//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             selectedIndexAddress = index;
//                           });
//                           print("Selected addr index");
//                           print(selectedIndexAddress);
//                         },
//                         child: Container(
//                           width: double.maxFinite,
//                           margin: EdgeInsets.only(bottom: 10, right: 10),
//                           padding: EdgeInsets.only(
//                               top: 25, bottom: 35, left: 15, right: 15),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   InkWell(
//                                     onTap: () async {
//                                       add = await Navigator.push(context,
//                                           MaterialPageRoute(
//                                         builder: (context) {
//                                           return AddressProductScr(
//                                             ischoice: true,
//                                             userid: widget.uid,
//                                           );
//                                         },
//                                       ));

//                                       setState(() {
//                                         print("Got Address id: ");
//                                         print(add);

//                                         print("Click location");
//                                         print(add['latitute']);
//                                         print(add['longtitute']);
//                                         // SendLatandLong(  double.parse(add['latitute']),   double.parse(add['longtitute']));

//                                         addressid = add['addressid'];
//                                         print("The location is ${addressid}");
//                                       });
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.location_on),
//                                         Text(
//                                           "Choose Locations",
//                                           style: TextStyle(fontSize: 12.8),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   InkWell(
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.map),
//                                         Text(
//                                           "Select On Map",
//                                           style: TextStyle(fontSize: 12.8),
//                                         )
//                                       ],
//                                     ),
//                                     onTap: () async {
//                                       var location =
//                                           await Location().getLocation();

//                                       print("User current location");
//                                       print(location.longitude);
//                                       print(location.latitude);

//                                       address = await Navigator.push(context,
//                                           MaterialPageRoute(
//                                         builder: (context) {
//                                           return GoogleMapScreen(
//                                             positionlong: location.longitude,
//                                             positionlat: location.latitude,
//                                           );
//                                         },
//                                       ));

//                                       setState(() {
//                                         print("Got Address back");
//                                         print(address);
//                                       });
//                                     },
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               if (previewimages != null)
//                                 Image.network(
//                                   '${previewimages}',
//                                   fit: BoxFit.cover,
//                                   width: double.maxFinite,
//                                   height: 180,
//                                 ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 '${add == null ? state.add?.results![len! - 1].street : add['street']}',
//                                 style: TextStyle(
//                                     fontSize: 14.8, color: Colors.black),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
