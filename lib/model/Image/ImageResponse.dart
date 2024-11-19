class Imageresponse {
  String? success;
  String? message;
  int? status;
  Url? url;

  Imageresponse({this.success, this.message, this.status, this.url});

  Imageresponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    url = json['url'] != null ? new Url.fromJson(json['url']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.url != null) {
      data['url'] = this.url!.toJson();
    }
    return data;
  }
}

class Url {
  int? id;
  String? images;

  Url({this.id, this.images});

  Url.fromJson(Map<String, dynamic> json) {
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
