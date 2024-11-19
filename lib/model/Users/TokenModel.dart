class TokenModel {
  String? refresh;
  String? access;
  User? user;

  TokenModel({this.refresh, this.access, this.user});

  TokenModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  bool? isowner;

  User({this.id, this.isowner});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isowner = json['isowner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isowner'] = this.isowner;
    return data;
  }
}
