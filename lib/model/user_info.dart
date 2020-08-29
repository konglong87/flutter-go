class UserInformation {
  String username;
  int id;
  String avatarPic;
  String themeColor;

  UserInformation({
    this.avatarPic,
    this.id,
    this.themeColor,
    this.username,
  });

  factory UserInformation.fromJson(dynamic json) {
//  factory UserInformation.fromJson(Map<String, dynamic> json) {
    print('fromJOSN $json   ${json['id'].runtimeType}');
    String name = json['name'].toString();
    int userId;
    if (json['name'] == null) {
      name = json['url_name'].toString();
    }
    if (json['id'] is int) {
//    if (json['id'].runtimeType == int) {
      userId = int.parse(json['id'].toString());
    } else {
      userId = int.parse(json['id'].toString());
    }
    return UserInformation(
        avatarPic: json['avatar_pic'].toString(),
        id: userId,
        username: name,
        themeColor: json['theme_color'].toString());
  }
}
