/// Created with Android Studio.
/// User: 一晟
/// Date: 2019/1/5
/// Time: 下午10:20
/// email: zhu.yan@alibaba-inc.com
/// target: FirstPageItem

import 'package:flutter_go/utils/util.dart';

class FirstPageItem {
  bool hot;
  String isCollection;
  String tag;
  String username;
  int collectionCount;
  int commentCount;
  String title;
  String createdTime;
  String detailUrl;

  FirstPageItem(
      {this.hot,
      this.tag,
      this.username,
      this.collectionCount,
      this.createdTime,
      this.commentCount,
      this.title,
      this.detailUrl,
      this.isCollection});

  factory FirstPageItem.fromJson(dynamic json) {
//  factory FirstPageItem.fromJson(Map<String, dynamic> json) {
    String _tag = '';
    if ((json['tags'] as List).length > 0) {
      _tag = '${json['tags'][0]['title']}/';
    }
    return FirstPageItem(
      hot: json['hot'] as bool,
      collectionCount: json['collectionCount'] as int,
      commentCount: json['commentsCount'] as int,
      tag: '$_tag${json['category']['name']}',
      username: json['user']['username'] as String,
      createdTime: Util.getTimeDuration(json['createdAt'].toString()),
      title: json['title'].toString(),
      detailUrl: json['originalUrl'].toString(),
      isCollection: json['type'].toString(),
    );
  }
}
