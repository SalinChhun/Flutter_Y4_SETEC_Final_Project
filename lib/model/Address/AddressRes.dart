class AddressModelResponse {
  int? id;
  CustomerId? customerId;
  String? street;
  String? city;
  String? latitude;
  String? longitude;
  String? description;
  String? country;

  AddressModelResponse(
      {this.id,
        this.customerId,
        this.street,
        this.city,
        this.latitude,
        this.longitude,
        this.description,
        this.country});

  AddressModelResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'] != null
        ? new CustomerId.fromJson(json['customer_id'])
        : null;
    street = json['street'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customerId != null) {
      data['customer_id'] = this.customerId!.toJson();
    }
    data['street'] = this.street;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['country'] = this.country;
    return data;
  }
}

class CustomerId {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? gender;
  Imgid? imgid;
  String? password;
  String? username;

  CustomerId(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.telephone,
        this.gender,
        this.imgid,
        this.password,
        this.username});

  CustomerId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    gender = json['gender'];
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['gender'] = this.gender;
    if (this.imgid != null) {
      data['imgid'] = this.imgid!.toJson();
    }
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}

class Imgid {
  int? id;
  String? images;

  Imgid({this.id, this.images});

  Imgid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    return data;
  }
}
