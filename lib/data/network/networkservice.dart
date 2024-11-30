import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/model/Address.dart';
import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:http/http.dart' as http;

import '../../model/Order/OrderRequest.dart';

class NetworkApiService {
  var url = '${ApiUrl.userloginurl}';

  Future<dynamic> FetchSuperDeal({page}) async {
    try {
      var res = await http.get(
        Uri.parse(ApiUrl.superdealurl),
      );
      print(res.statusCode);
      // print(res.body);
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      throw "No Internet";
    }
  }

  Future<dynamic> FetchSuperDealSingle({id}) async {
    try {
      var res = await http.get(
        Uri.parse(ApiUrl.superdealsingleurl + id.toString()),
      );
      print(res.statusCode);
      // print(res.body);
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      throw "No Internet";
    }
  }

  Future<dynamic> ObtainToken(String? token) async {
    try {
      print("Inside network api");

      var res = await http.post(Uri.parse(ApiUrl.refreshtoken), body: {
        "refresh": "${token}",
      });
      print(res.statusCode);
      print(res.body);
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      throw "No Internet";
    }
  }

  Future<dynamic> AuthUser(String? email, String? password) async {
    try {
      print('login service work ${email}, ${password}');
      var res = await http.post(Uri.parse(ApiUrl.authlogin),
          body: {"email": "${email}", "password": "${password}"});
      print('res.statusCode ${res.statusCode}');
      print(res.body);
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> LoginSocialAuthUser(String? email) async {
    try {
      var res = await http
          .post(Uri.parse(ApiUrl.authlogingoogle), body: {"email": "${email}"});
      print(res.statusCode);

      if (res.statusCode == 200 || res.statusCode == 201) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      }
      if (res.statusCode == 400) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> FetchUser(String? url) async {
    try {
      var res = await http.get(Uri.parse(url!));
      // print(res.statusCode);

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> SendCode(String? url, email) async {
    try {
      var res = await http.post(Uri.parse(url!), body: {
        "email": "${email}",
      });
      print(res.statusCode);

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      }
      if (res.statusCode == 202) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> VerifyCode(String? url, email, code) async {
    try {
      var res = await http.post(Uri.parse(url!),
          body: {"email": "${email}", "code": "${code}"});
      print(res.statusCode);

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 202) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      }
      if (res.statusCode == 400) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> Changepassword(String? url, email, pass) async {
    try {
      var res = await http.post(Uri.parse(url!),
          body: {"email": "${email}", "password": "${pass}"});
      print(res.statusCode);

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AuthSignUpUser(fname, lname, String? email, String? password,
      String? telephone, String? username, String gender) async {
    try {
      var tel = "+" + telephone.toString();

      var res = await http
          .post(Uri.parse('http://localhost:8000/auth/register'), body: {
        "firstname": fname,
        "lastname": lname,
        "email": email,
        "username": username,
        "password": password,
        "telephone": tel,
        "gender": gender,
      });
      print("work hah" + res.body);
      print(res.statusCode);
      print(res.body.toString());
      if (res.statusCode == 201) {
        return json.decode(res.body);
      }
      if (res.statusCode == 401) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AuthRegisterGoogle(
      String? email, String? password, username, telephone) async {
    try {
      // print("Register user");
      print(telephone);
      var tel = "+" + telephone.toString();
      var res =
          await http.post(Uri.parse(ApiUrl.authgoogleauthregister), body: {
        "email": email,
        "username": username,
        "password": password,
        "telephone": tel,
      });
      print(res.statusCode);
      print(res.body.toString());
      if (res.statusCode == 201) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> UserEditing(fname, lname, String? telephone, String? username,
      String gender, imgid, uid, url) async {
    try {
      // print("Register user");
      print(telephone);
      var res;

      var tel = telephone.toString();
      print(tel);

      print("Image id is ${imgid}");

      res = await http.put(Uri.parse(url), body: {
        "username": "${username}",
        "firstname": "${fname}",
        "lastname": "${lname}",
        "telephone": "${tel}",
        "gender": "${gender}",
        "imgid": imgid.toString()
      });

      print(res.statusCode);
      print(res.body.toString());
      if (res.statusCode == 201) {
        return json.decode(res.body);
      } else {
        print("Error during communication");
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> GetAllproduct(url, search, {page}) async {
    try {
      print(page);
      var res = await http.get(
        Uri.parse("${url}?page=${page}"),
      );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> GetReviewUser(url, pid) async {
    try {
      print(pid);

      var res = await http.get(
        Uri.parse("${url}${pid}"),
      );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> PostReviewUser(url, userid, desc, rating, productid) async {
    try {
      print(userid);

      var res = await http.post(Uri.parse("${url}${userid}"), body: {
        "description": "${desc}",
        "rating": "${rating.toInt()}",
        "product": "${productid}"
      });
      print("Post Review Status");
      print(res.statusCode);
      print(res.body.toString()); //
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> Postmessage(url, userid, title) async {
    try {
      var res = await http
          .post(Uri.parse("${url}${userid}"), body: {"title": "${title}"});
      print(res.statusCode);
      print(res.body.toString()); //
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> Sortproduct(url, sort, rank, {search, page}) async {
    try {
      print(url);
      print(sort);
      print("${url}/sort?${sort}=${rank}&page=${page}");
      if (search == null) {
        search = "";
      }
      print("Pagination now is ${page}");
      var mainurl;
      if (page == null) {
        page = 1;
      }

      mainurl = "${url}/sort?search=${search}&${sort}=${rank}&page=${page}";

      print(mainurl);

      var res = await http.get(
        Uri.parse(mainurl),
      );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> FilterProduct(url, search,
      {maxprice, minprice, cid, sort, rank}) async {
    try {
      if (search == null) {
        search = "";
      }
      if (rank == null) {
        rank = "DESC";
      }
      if (sort == null) {
        url =
            '${url}?search=${search}&min_price=${minprice}&max_price=${maxprice}&category=${cid}';
      } else {
        url =
            '${url}?search=${search}&min_price=${minprice}&max_price=${maxprice}&category=${cid}&${sort}=${rank}';
      }
      print(url);
      var res = await http.get(
        Uri.parse(url),
      );
      print(res.statusCode);
      print("Filtering ");
      // print(res.body.toString());

      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> Searchproduct(url, search, {page}) async {
    try {
      var res = await http.get(
        Uri.parse('${url}?search=${search}&page=${page}'),
      );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AddressPost(
      String? url, AddressBody addressbody, uid, desc) async {
    try {
      print(addressbody);

      var res = await http.post(
        Uri.parse('${url}${uid}'),
        body: {
          "street": addressbody.street,
          "city": addressbody.country,
          "latitude": addressbody.lat.toString(),
          "longitude": addressbody.lon.toString(),
          "country": addressbody.country,
          "description": "${desc}"
        },
        //     headers: {
        //       'Content-type': 'application/json',
        //       'Accept': 'application/json'
        //       // "Authorization": "Some token"
        //
        // }
      );
      print(res.statusCode);

      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AddressPatch(
      String? url, AddressBody addressbody, uid, aid, desc) async {
    try {
      print(addressbody);

      var res = await http.put(
        Uri.parse('${url}/${aid}'),
        body: {
          "street": addressbody.street,
          "city": addressbody.country,
          "latitude": addressbody.lat.toString(),
          "longitude": addressbody.lon.toString(),
          "country": addressbody.country,
          "description": desc
        },
        //     headers: {
        //       'Content-type': 'application/json',
        //       'Accept': 'application/json'
        //       // "Authorization": "Some token"
        //
        // }
      );
      // print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> DeleteAddress(addid) async {
    try {
      print(addid);

      var res = await http.delete(
        Uri.parse('${ApiUrl.addressurlput}/${addid}'),

        //     headers: {
        //       'Content-type': 'application/json',
        //       'Accept': 'application/json'
        //       // "Authorization": "Some token"
        //
        // }
      );
      // print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AddFavorite(pid, uid) async {
    try {
      var res = await http.post(Uri.parse('${ApiUrl.addproductfavurl}/${pid}'),
          body: {'user': '${uid}'}

          //     headers: {
          //       'Content-type': 'application/json',
          //       'Accept': 'application/json'
          //       // "Authorization": "Some token"
          //
          // }
          );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> FetchFavorite(uid) async {
    try {
      var res = await http.get(
        Uri.parse('${ApiUrl.addproductfavurl}/${uid}'),

        //     headers: {
        //       'Content-type': 'application/json',
        //       'Accept': 'application/json'
        //       // "Authorization": "Some token"
        //
        // }
      );
      print(res.statusCode);
      print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> FetchFavoriteById(uid, pid) async {
    try {
      var res = await http.get(
        Uri.parse('${ApiUrl.productfavbyid}${pid}/${uid}'),

        //     headers: {
        //       'Content-type': 'application/json',
        //       'Accept': 'application/json'
        //       // "Authorization": "Some token"
        //
        // }
      );
      // print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> RemoveFavorite(pid, uid) async {
    try {
      var res = await http.post(
          Uri.parse('${ApiUrl.addproductfavurl}/${pid}/delete'),
          body: {'user': '${uid}'}

          //     headers: {
          //       'Content-type': 'application/json',
          //       'Accept': 'application/json'
          //       // "Authorization": "Some token"
          //
          // }
          );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AddressFetch(uid) async {
    try {
      var url = ApiUrl.addressuser;

      var res = await http.get(
        Uri.parse('${url}${uid}'),
        //     headers: {
        //       'Content-type': 'application/json',
        //       'Accept': 'application/json'
        //       // "Authorization": "Some token"
        //
        // }
      );
      // print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

//
  Future<dynamic> GetAllCategory(url) async {
    try {
      var res = await http.get(
        Uri.parse(url),
      );
      print("The category ");
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("Category server break down");
      print("No internet during communication");
    }
  }

  Future<dynamic> GetProductCategory(url) async {
    try {
      var res = await http.get(
        Uri.parse(url),
      );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> GetOrderSummary(url, oid) async {
    try {
      print(url);
      print(oid);
      var urlhere = "${url}${oid}";
      print(urlhere);
      var res = await http.get(
        Uri.parse('${urlhere}'),
      );
      print(res.statusCode);
      // print(res.body.toString());

      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> GetOrderUser(url, uid) async {
    try {
      print(url);
      print(uid);
      var urlhere = "${url}${uid}";
      print(urlhere);
      var res = await http.get(
        Uri.parse('${urlhere}'),
      );
      print(res.statusCode);
      // print(res.body.toString());
      return json.decode(responseStatusCheck(res));
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> PostOrder(
      String? url, addressid, OrderRequestV2? orderRequestV2) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'csrftoken=5jwKWckjCPQiV1By2uxkB39vNJaaWult'
    };
    var request = http.Request('POST', Uri.parse('${url}${addressid}'));

    if (url == null || addressid == null || orderRequestV2 == null) {
      // Handle the error here
      return;
    }
    List<Map<String, dynamic>> jsonList =
        orderRequestV2.productss!.map((item) => item.toJson()).toList();

    //  print(jsonList);
    request.body = json.encode({
      "method": '${orderRequestV2.method}',
      "products": jsonList.toList(),
      "customer": '${orderRequestV2.customer}'
    });
    print('order request body ${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // print(await response.stream.bytesToString());
    print(response.statusCode);
    if (response.statusCode == 201) {
      var res = await response.stream.bytesToString();

      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> UploadImage(url, {imagepath}) async {
    try {
      print(url);

      print(url);
      var request = http.MultipartRequest('POST', Uri.parse('${url}'));
      request.files
          .add(await http.MultipartFile.fromPath('images', '${imagepath}'));

      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        var jsonres = await response.stream.bytesToString();
        return json.decode(jsonres);
      } else {
        print(response.reasonPhrase);
      }

      // print(res.body.toString());
      // return json.decode(responseStatusCheck(response));
    } on SocketException {
      print("No internet during communication");
    }
  }

  responseStatusCheck(http.Response res) {
    print(res.body);
    if (res.statusCode == 200) {
      return res.body;
    }
    if (res.statusCode == 201) {
      print("Valid");
      return res.body;
    }
    if (res.statusCode == 400) {
      return res.body;
    }
    if (res.statusCode == 401) {
      return res.body;
    } else {
      print("Error during communication");
    }
  }
}
