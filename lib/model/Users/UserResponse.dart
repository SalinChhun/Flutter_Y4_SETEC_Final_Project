class UserResponse {
  String? username;
  String? firstname;
  String? lastname;
  String? telephone;
  String? gender;
  int? imgid;

  UserResponse(
      {this.username,
        this.firstname,
        this.lastname,
        this.telephone,
        this.gender,
        this.imgid});

  UserResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    telephone = json['telephone'];
    gender = json['gender'];
    imgid = json['imgid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['telephone'] = this.telephone;
    data['gender'] = this.gender;
    data['imgid'] = this.imgid;
    return data;
  }
}
