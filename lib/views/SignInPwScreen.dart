import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customviews/CustomBottomDialog.dart';
import 'customviews/CustomLoading.dart';

class SignInPwScreen extends StatefulWidget {
  Map args;
  SignInPwScreen({@required this.args}) ;

  @override
  _SignInPwScreen createState() => _SignInPwScreen();
}

class _SignInPwScreen extends State<SignInPwScreen> {

  final _pwController = TextEditingController();
  final _formPw = GlobalKey<FormState>();

  BuildContext _bottomSheetBuildContext;

  SignInProvider signInProvider;

  bool isLoading = false;
  

  @override
  void initState() {
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtils.c_ffffff,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(StringUtils.signin_title, style: TextStyle(color: ColorUtils.c_000000)),
      ),

      body: Form(
          key: _formPw,
          child: Stack(children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView(children: <Widget>[
                  _pwEdit(),
                  _signInButton(),
                ])),
            isLoading ? CustomLoading() : Container(),
          ])),
    );
  }

  Widget _pwEdit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 80, 0, 60),
      child: TextFormField(
        controller: _pwController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: StringUtils.signin_pw,
            hintText: StringUtils.signin_pw_hint),
        validator: (value) {
          if (value.length < 8) return StringUtils.signin_pw_err;
          return null;
        },
        onChanged: (value) {
          setState(() {});
          _formPw.currentState.validate();
        },
      ),
    );
  }

  Widget _signInButton() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: isBtnValid()
              ? () async {
            onSignIn();
          }
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ColorUtils.c_004680,
          textColor: ColorUtils.c_ffffff,
          disabledColor: ColorUtils.c_e6e6e6,
          child: Text(StringUtils.signin_title),
        ));
  }

  /// 다이얼로그 취소
  bottomSheetCancel() {
    Navigator.pop(_bottomSheetBuildContext);
  }

  /// 다이얼로그 확인
  bottomSheetConfirm() {
    Navigator.pop(_bottomSheetBuildContext);
    nextMain();
  }

  /// 로그인 버튼 활성화 여부
  bool isBtnValid() {
    return _pwController.text.length >= 8;
  }

  /// 로그인 버튼 클릭
  void onSignIn() async {
    FocusManager.instance.primaryFocus.unfocus();
    setState(() => isLoading = true);

    var prefs = await SharedPreferences.getInstance();
    var instanceId = prefs.getString(Constants.INSTANCE_ID) ?? '';

    Map dataMap = {
      'methodid': Constants.JW2001,
      'email': '${widget.args['email']}',
      'password': '${_pwController.text}',
      'provider': instanceId
    };

    final reqData = await signInProvider.jw2001(dataMap);

    setState(() => isLoading = false);

    if (reqData == null) {
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
      return;
    }

//    String emailValid = reqData.emailValid.toString();
//    if ("Y" == emailValid) {
//      nextPwInput();
//    } else if ("N" == emailValid) {
//      showModalBottomSheet(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(15.0),
//                topRight: Radius.circular(15.0)),
//          ),
//          context: context,
//          builder: (context) {
//            _bottomSheetBuildContext = context;
//            return CustomBottomDialog().buildTwoButtonBottomSheet(
//                context,
//                StringUtils.notice,
//                StringUtils.signin_dialog_msg,
//                StringUtils.btn_cancel,
//                bottomSheetCancel,
//                StringUtils.btn_confrim,
//                bottomSheetConfirm);
//          },
//          isDismissible: false,
//          enableDrag: false);
//    }
  }

  Future nextMain() async {
//    Navigator.of(context).push(
//        MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
