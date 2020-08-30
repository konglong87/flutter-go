class Data {
  String version;
  String name;

  Data.fromJson(Map<String, dynamic> json)
      : version = json['version'].toString(),
        name = json['name'].toString();

  @override
  String toString() {
    return 'name: $name ,version: $version';
  }
}

class Version {
  Data data;
  int status;
  bool success;

  Version.formJson(Map<String, dynamic> json)
      : status = json['status'] as int,
        success = json['success'] as bool,
        data = Data.fromJson(json['data'] as Map<String,dynamic>);

  @override
  String toString() {
    return 'status: $status ,success: $success,date: ${data.toString()}';
  }
}
