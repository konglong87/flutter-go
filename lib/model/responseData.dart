class ResponseData {
  int status;
  bool success;
  String message;

  ResponseData(this.status, this.success, this.message);

  ResponseData.fromJson(Map<String, dynamic> json)
      : status = json['status'] as int,
        success = json['success'] as bool,
        message = json['message'].toString();

  Map<String, dynamic> toJson() =>
      {'status': status, 'success': success, 'messsage': message};

  @override
  String toString() {
    return 'status: $status ,success: $success,message: ${message.toString()}';
  }
}
