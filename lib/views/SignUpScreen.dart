
import 'package:flutter/material.dart';
import 'package:fluttertestapp/provider/SignUpProvider.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:fluttertestapp/utils/UICommonUtils.dart';
import 'package:fluttertestapp/views/MainListScreen.dart';
import 'package:provider/provider.dart';

import 'BasePageScreen.dart';

class SignUpScreen extends BasePageScreen {
  final Map args;
  SignUpScreen({@required this.args}) ;

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends BasePageScreenState<SignUpScreen>  with BaseScreen{
  final _pwController = TextEditingController();
  final _pw2Controller = TextEditingController();
  final _formPw = GlobalKey<FormState>();


  SignUpProvider signUpProvider;

  @override
  String appBarTitleText() {
    return StringUtils.signupTitle;
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
              _pw2Edit(),
              _signUpButton(),
            ])),
      ),
    );
  }

  @override
  void initState() {
    signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _pwController.dispose();
    _pw2Controller.dispose();
    super.dispose();
  }

  Widget _pwEdit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: TextFormField(
        controller: _pwController,
        obscureText: true,
        decoration: UICommonUtils().commonInputDecoration(
            StringUtils.signupPw, StringUtils.signupPwHint),
        validator: (value) {
          if (value.length < 8) return StringUtils.signupPwHint;
          return null;
        },
        onChanged: (value) {

          _formPw.currentState.validate();
          setState(() {});
        },
      ),
    );
  }

  Widget _pw2Edit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: TextFormField(
        controller: _pw2Controller,
        obscureText: true,
        decoration: UICommonUtils().commonInputDecoration(
            StringUtils.signupPw2, StringUtils.signupPw2Hint),
        validator: (value) {
          if (value !=_pwController.text) {
            return StringUtils.signupPw2Err;
          }
          return null;
        },
        onChanged: (value) {

          _formPw.currentState.validate();
          setState(() {});
        },
      ),
    );
  }

  Widget _signUpButton() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 80, 0, 20),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: UICommonUtils().commonRaisedButton(
            isBtnValid(), onSignUp, StringUtils.signupTitle)
    );
  }

  void onSignUp() async {
    FocusManager.instance.primaryFocus.unfocus();
    setState(() => isLoading = true);

    var instanceId = await getInstanceId();

    Map dataMap = {
      'methodid': Constants.JW1002,
      'email': '${widget.args['email']}',
      'password': '${_pwController.text}',
      'provider': instanceId
    };

    final reqData = await signUpProvider.jw1002(dataMap);

    setState(() => isLoading = false);

    if (reqData == null) {
      showNetworkErrorDialog();
      return;
    }

  }

  /// 회원가입 버튼 활성화 여부
  bool isBtnValid() {
    if(_pwController.text.length >= 8) {
      return _pwController.text == _pw2Controller.text;
    }
    return false;
  }


  Future nextSignUp() async{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainListScreen()));
  }

}
