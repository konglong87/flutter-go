import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_go/components/list_view_item.dart';
import 'package:flutter_go/components/list_refresh.dart' as listComp;
import 'package:flutter_go/components/pagination.dart';
import 'package:flutter_go/views/first_page/first_page_item.dart';
import 'package:flutter_go/components/disclaimer_msg.dart';
import 'package:flutter_go/utils/net_utils.dart';

// ValueKey<String> key;

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;
  GlobalKey<DisclaimerMsgState> key;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (key == null) {
      key = GlobalKey<DisclaimerMsgState>();
      // key = const Key('__RIKEY1__');
      //获取sharePre
      _unKnow = _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool('disclaimer::Boolean') ?? false);
      });

      /// 判断是否需要弹出免责声明,已经勾选过不在显示,就不会主动弹
      _unKnow.then((bool value) {
        new Future.delayed(const Duration(seconds: 1), () {
          if (!value &&
              key.currentState is DisclaimerMsgState &&
              key.currentState.showAlertDialog is Function) {
            key.currentState.showAlertDialog(context);
          }
        });
      });
    }
  }

  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    print("进入try；额....111111....");
    /// const juejin_flutter = 'https://timeline-merger-ms.juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';
    const juejin_flutter =
        'http://123.207.32.32:8001/api/meal';
//        'https://juejin.im/recommended?sort=newest';
//        'https://fluttergo.pub:9527/juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';

    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param = {'page': pageIndex, 'pageSize': 20, 'sort': 'rankIndex'};
    var responseList = [];
    var pageTotal = 0;

    print("进入try；额....222222....");
    try {
      print("进入try；额....001233333333....");
//      var response = await NetUtils.get(juejin_flutter, _param);
      var response = await NetUtils.get(juejin_flutter, null);
      print("返回值[response][][][response]=== $response");


//      String mm  = response["meal"].toString() ?? "";
//
//      print("[][mmm][==> $mm");

//      var responseList2  =  json.decode(mm);

      final mealArry = response["meal"];
      print ("==mealArry====$mealArry");

      for(var json in mealArry){
        print("json=0000000===> $json");
//        responseList.add(json);
      }

      responseList = mealArry as List;


//      var responseList2  =  json.decode(response['meal']);
      print("responseList2=======> $responseList");

//      responseList  =  json.decode(response['meal'].toString()) as List;
      print("返回值[responseList]=== $responseList");
      print("返回值[responseList]len=== ${responseList.length}");
      print("返回值[responseList]len=== ${responseList.length}");
      print("返回值[responseList]len=== ${responseList.length}");
      print("返回值[responseList]len=== ${responseList.length}");
      print("返回值[responseList]len=== ${responseList.length}");
//      responseList  =  json.decode(response['d']['entrylist'].toString()) as List;
//      responseList =  response['d']['entrylist'];
      pageTotal = 27;
//      pageTotal = int.parse(response['count'].toString() ?? "27");
      print("返回值[pageTotal]=== $pageTotal");
//      pageTotal = int.parse(response['d']['total'].toString());
      if (!(pageTotal is int) || pageTotal <= 0 || pageTotal == null) {
        pageTotal = 0;
      }
    } catch (e) {
//      print("【错误】【first_page】err====$e");
      print("【错误】【first_page】err====$e");
    }
    pageIndex += 1;
    List resultList = new List();
//    for (int i = 0; i < responseList.length; i++) {
    int len  = responseList.length;
    for (int i = 0; i < len; i++) {
      try {
        FirstPageItem cellData = new FirstPageItem.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        print("【错误】【first_page】【resultList转换】err====$e");
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {
      "list": resultList,
      'total': pageTotal,
      'pageIndex': pageIndex
    };
    return result;
  }

  /// 每个item的样式
  Widget makeCard(index, item) {
    var myTitle = '${item.title}';
    var myUsername = '${'👲'}: ${item.username} ';
    var codeUrl = '${item.detailUrl}';
    return new ListViewItem(
      itemUrl: codeUrl,
      itemTitle: myTitle,
      data: myUsername,
    );
  }

  headerView() {
    return Column(
      children: <Widget>[
        Stack(
            //alignment: const FractionalOffset(0.9, 0.1),//方法一
            children: <Widget>[
              Pagination(),
              Positioned(
                  //方法二
                  top: 10.0,
                  left: 0.0,
                  child: DisclaimerMsg(key: key, pWidget: this)),
            ]),
        SizedBox(
            height: 1, child: Container(color: Theme.of(context).primaryColor)),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Column(children: <Widget>[
//          new Stack(
//            //alignment: const FractionalOffset(0.9, 0.1),//方法一
//            children: <Widget>[
//            Pagination(),
//            Positioned(//方法二
//              top: 10.0,
//              left: 0.0,
//              child: DisclaimerMsg(key:key,pWidget:this)
//            ),
//          ]),
//          SizedBox(height: 2, child:Container(color: Theme.of(context).primaryColor)),
      new Expanded(
          //child: new List(),
          child: listComp.ListRefresh(getIndexListData, makeCard, headerView))
    ]);
  }
}
