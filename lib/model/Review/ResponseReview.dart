// class   ResponseReview {
//   int? id;
//   String? description;
//   int? rating;
//   String? createdAt;
//   String? updatedAt;
//
//   ResponseReview(
//       {this.id, this.description, this.rating, this.createdAt, this.updatedAt});
//
//   ResponseReview.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     description = json['description'];
//     rating = json['rating'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['description'] = this.description;
//     data['rating'] = this.rating;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
class ResponseReview {
  String? description;
  int? rating;

  ResponseReview({this.description, this.rating});

  ResponseReview.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['rating'] = this.rating;
    return data;
  }
}
