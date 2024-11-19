class UserModel {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? gender;
  Imgid? imgid;
  String? username;
  String? createdDate;

  UserModel(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.telephone,
        this.gender,
        this.imgid,
        this.username,
        this.createdDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    gender = json['gender'];
    imgid = json['imgid'] != null ? new Imgid.fromJson(json['imgid']) : null;
    username = json['username'];
    createdDate = json['created_date'];
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
    data['username'] = this.username;
    data['created_date'] = this.createdDate;
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
