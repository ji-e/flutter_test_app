import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customviews/CustomBottomDialog.dart';
import 'customviews/CustomLoading.dart';

abstract class BasePageScreen extends StatefulWidget {
  BasePageScreen({Key key}) : super(key: key);
}

abstract class BasePageScreenState<Page extends BasePageScreen>
    extends State<Page> {
  String appBarTitleText();

  dynamic appBarTitleColor();

  var _bottomSheetBuildContext;
  bool isLoading = false;

  bool _isSetting = false;

  void setIsSetting(isSetting) {
    _isSetting = isSetting;
  }
}

mixin BaseScreen<Page extends BasePageScreen> on BasePageScreenState<Page> {
  @override
  Widget build(BuildContext context) {
    var titleColor = isLoading ? ColorUtils.c_55000000 : appBarTitleColor();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: titleColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
//          flexibleSpace: Container(
//            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                    colors: [Colors.blue.shade200, Colors.pink.shade300]
//                )
//            ),
//          ),
          title: Text(
            appBarTitleText(),
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
          actions: [
            _isSetting ? IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                onSettingClick();
              },
            ) : Container()
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
            color: ColorUtils.c_ffffff,
            child: body(),
          ),
          isLoading ? CustomLoading() : Container(),
        ]));
  }

  Widget body();

  /// 세팅버튼 클릭
  void onSettingClick(){
    LogUtils(StackTrace.current).d("setting");
  }

  /// 네트워크 에러 다이얼로그
  dynamic showNetworkErrorDialog() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          _bottomSheetBuildContext = context;
          return CustomBottomDialog().buildTwoButtonBottomSheet(
            context,
            StringUtils.notice,
            StringUtils.signinNetworkMsg,
            null,
            null,
            StringUtils.btnConfirm,
            networkErrButtonClick,
          );
        },
        isDismissible: false,
        enableDrag: false);
  }

  /// 버튼 2개 다이얼로그
  dynamic showDialogTwoButtonDialog(context, title, strMsg, strCancel,
      bottomSheetCancel, strConfirm, bottomSheetConfirm) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return CustomBottomDialog().buildTwoButtonBottomSheet(
              context,
              title == null ? StringUtils.notice : title,
              strMsg,
              strCancel == null ? StringUtils.btnCancel : strCancel,
              bottomSheetCancel,
              strConfirm == null ? StringUtils.btnConfirm : strConfirm,
              bottomSheetConfirm);
        },
        isDismissible: false,
        enableDrag: false);
  }

  /// 버튼 1개 다이얼로그
  dynamic showDialogOneButtonDialog(context, title, strMsg, strConfirm, bottomSheetConfirm) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          return CustomBottomDialog().buildTwoButtonBottomSheet(
              context,
              title == null ? StringUtils.notice : title,
              strMsg,
              null, null,
              strConfirm == null ? StringUtils.btnConfirm : strConfirm,
              bottomSheetConfirm);
        },
        isDismissible: false,
        enableDrag: false);
  }

  /// 다이얼로그 취소
  networkErrButtonClick() {
    Navigator.pop(_bottomSheetBuildContext);
  }


  /// InstancId
  Future getInstanceId() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.INSTANCE_ID) ?? '';
  }

}
