import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:fluttertestapp/utils/UICommonUtils.dart';
import 'package:fluttertestapp/views/MainListScreen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';

import 'BasePageScreen.dart';


class SignInPwScreen extends BasePageScreen {
  final Map args;
  SignInPwScreen({@required this.args}) ;

  @override
  _SignInPwScreen createState() => _SignInPwScreen();
}

class _SignInPwScreen extends BasePageScreenState<SignInPwScreen> with BaseScreen{

  final _pwController = TextEditingController();
  final _formPw = GlobalKey<FormState>();

  SignInProvider signInProvider;

  @override
  String appBarTitleText() {
    return StringUtils.signinTitle;
  }
  @override
  dynamic appBarTitleColor() {
    return ColorUtils.c_ffffff;
  }


  @override
  Widget body() {
    return Scaffold(
      body: Form(
        key: _formPw,
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(children: <Widget>[
              _pwEdit(),
              _signInButton(),
            ])),
      ),
    );
  }
  

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

  Widget _pwEdit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: TextFormField(
        controller: _pwController,
        obscureText: true,
        decoration:  UICommonUtils().commonInputDecoration(
          StringUtils.signinPw, StringUtils.signinPwHint),
        validator: (value) {
          if (value.length < 8) return StringUtils.signinPwErr;
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
        margin: EdgeInsets.fromLTRB(0, 80, 0, 20),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: UICommonUtils().commonRaisedButton(
            isBtnValid(), onSignIn, StringUtils.signinTitle)
    );
  }

  /// 다이얼로그 취소
  bottomSheetCancel() {
    Navigator.pop(context);
  }

  /// 다이얼로그 확인
  bottomSheetConfirm() {
    Navigator.pop(context);
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

    var instanceId = await getInstanceId();
    LogUtils(StackTrace.current).d('Instance ID: $instanceId');
    Map dataMap = {
      'methodid': Constants.JW2001,
      'email': '${widget.args['email']}',
      'password': '${_pwController.text}',
      'provider': instanceId
    };

    final reqData = await signInProvider.jw2001(dataMap);

    setState(() => isLoading = false);

    if (reqData == null) {
      showNetworkErrorDialog();
      return;
    }

    String signInValid = reqData.signInValid.toString();
    if ("Y" == signInValid) {
      nextMain();
    } else if ("N" == signInValid) {
      showDialogOneButtonDialog(
          context,
          null,
          StringUtils.signinDialogMsg2,
          null, bottomSheetConfirm);
    }
  }

  Future nextMain() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainListScreen()));
  }
}
