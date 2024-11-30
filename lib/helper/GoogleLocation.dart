import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

class LocationHelper {
  var longitute;
  var latitute;
  static const GOOGLE_API_KEY = "AIzaSyCh-zW5BLV8oll7nn7ZzBfniWKI0iEDAuM";
  LocationHelper({this.longitute, this.latitute});

  String generateGoogleMapPreview(
      double longtitute, double latitute, double zoom) {
    return """
  https://maps.googleapis.com/maps/api/staticmap?center=&${longitute},${latitute}&zoom=$zoom&size=600x300&maptype=roadmap
&markers=color:red%7Clabel:C%7C${longitute},${latitute}
&key=${GOOGLE_API_KEY}
 
  """;
  }

  // Handle real local
  // static String? staticmapurl({double? latitute, double? longtitute}) {
  //   print(latitute);
  //   print(longtitute);
  //   final std =
  //       "https://maps.googleapis.com/maps/api/staticmap?center=&${latitute},${longtitute}zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${latitute},${longtitute}&key=AIzaSyCh-zW5BLV8oll7nn7ZzBfniWKI0iEDAuM";
  //   print(std);
  //   return std;
  // }

  // Handle fake location
  static String staticmapurl({double? latitute, double? longtitute}) {
    // Return a placeholder image URL with coordinates as text
    return 'https://via.placeholder.com/600x300.png?text=Fake+Map+($latitute,$longtitute)';
  }

// Map<String,dynamic>
  Future<List<double?>> currentUserLocation() async {
    var location = await Location().getLocation();
    var locations = [location.longitude, location.latitude];
    return locations;
  }

  Future<String?> getPlaceId(String? inputuser) async {
    print(inputuser);
    var url = """
   https://maps.googleapis.com/maps/api/place/findplacefromtext/json
  &input=${inputuser}
  &inputtype=textquery
  &key=${GOOGLE_API_KEY}
    
    """;
    try {
      var response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=${inputuser}&inputtype=textquery&key=$GOOGLE_API_KEY'));
      // print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var placeid = result['candidates'][0]['place_id'] as String;
        return placeid;
      }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPlaceDetail(String? placeid) async {
    try {
      var response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$GOOGLE_API_KEY'));
      // print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);

        return result['result'] as Map<String, dynamic>;
      }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  Future<List<dynamic>?> getPlaceWithLatLng(double lat, double long) async {
    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat.toString()},${long.toString()}&&key=$GOOGLE_API_KEY';
    print("Sending Lat and long waiting");
    try {
      var response = await http.get(Uri.parse(url));
      // print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        // print(result);
        // print(result['results']);

        return result['results'] as List<dynamic>;
      }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }
}
