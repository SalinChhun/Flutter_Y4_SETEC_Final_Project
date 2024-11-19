class MessageRegister {
  String? message;

  MessageRegister({this.message});

  MessageRegister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}
