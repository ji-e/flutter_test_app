import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';

import 'customviews/CustomBottomDialog.dart';

abstract class BasePageScreen extends StatefulWidget {
  BasePageScreen({Key key}) : super(key: key);
}
abstract class BasePageScreenState<Page extends BasePageScreen> extends State<Page> {
  String appBarTitle();

  var _bottomSheetBuildContext;


}

mixin BaseScreen<Page extends BasePageScreen> on BasePageScreenState<Page> {

  dynamic showNetworkErrorDialog(){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          _bottomSheetBuildContext = context;
          return CustomBottomDialog().buildTwoButtonBottomSheet(
            context,
            StringUtils.notice,
            StringUtils.signin_network_msg,
            null,
            null,
            StringUtils.btn_confrim,
            bottomSheetCancel,
          );
        },
        isDismissible: false,
        enableDrag: false);
  }


  /// 다이얼로그 취소
  bottomSheetCancel() {
    LogUtils(StackTrace.current).d("erererererer");
    Navigator.pop(_bottomSheetBuildContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtils.c_ffffff,
          automaticallyImplyLeading: false,
//          flexibleSpace: Container(
//            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                    colors: [Colors.blue.shade200, Colors.pink.shade300]
//                )
//            ),
//          ),
          title: Text(
            appBarTitle(),
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
//          leading: _isBack ? IconButton(
//            icon: Icon(
//              Icons.arrow_back_ios,
//              color: Colors.black,
//            ),
//            onPressed: () {
//              onClickBackButton();
//            },
//          ) : Container(),
//          actions: [
//            _isCart ? IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//                color: Colors.black,
//              ),
//              onPressed: () {
//                onClickCart();
//              },
//            ) : Container()
//          ],
        ),
        body: Container(
          child: body(),
          color: ColorUtils.c_ffffff
        ));
  }

  Widget body();
}