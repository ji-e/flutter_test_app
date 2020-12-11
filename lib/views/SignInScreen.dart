import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/UICommonUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:provider/provider.dart';

import 'BasePageScreen.dart';
import 'SignInPwScreen.dart';
import 'SignUpScreen.dart';

class SignInScreen extends BasePageScreen {
  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends BasePageScreenState<SignInScreen> with BaseScreen {
  final _emailController = TextEditingController();
  final _formEmail = GlobalKey<FormState>();

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
        key: _formEmail,
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(children: <Widget>[
              _emailEdit(),
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
    _emailController.dispose();
    super.dispose();
  }

  Widget _emailEdit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      height: 70,
      child: TextFormField(
        controller: _emailController,
        decoration: UICommonUtils().commonInputDecoration(
            StringUtils.signinEmail, StringUtils.signinEmailHint),
        validator: (value) {
          return (!RegExp(Constants.EMAIL_PATTERN).hasMatch(value))
              ? StringUtils.signinEmailErr
              : null;
        },
        onChanged: (value) {
          setState(() {});
          _formEmail.currentState.validate();
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
            isBtnValid(), onContinue, StringUtils.signinBtnContinue)
    );
  }

  /// 다이얼로그 취소
  bottomSheetCancel() {
    Navigator.pop(context);
  }

  /// 다이얼로그 확인
  bottomSheetConfirm() {
    Navigator.pop(context);
    nextSignUpInput();
  }

  /// 계속하기 버튼 활성화 여부
  bool isBtnValid() {
    if (_emailController.text.isEmpty) {
      return false;
    }
    return _formEmail.currentState.validate();
  }

  /// 계속하기 버튼 클릭
  void onContinue() async {
    FocusManager.instance.primaryFocus.unfocus();
    setState(() => isLoading = true);

    Map dataMap = {
      'methodid': Constants.JW1001,
      'email': '${_emailController.text}'
    };

    final reqData = await signInProvider.jw1001(dataMap);

    setState(() => isLoading = false);

    if (reqData == null) {
      showNetworkErrorDialog();
      return;
    }

    String emailValid = reqData.emailValid.toString();
    if ("Y" == emailValid) {
      nextPwInput();
    } else if ("N" == emailValid) {
      showDialogTwoButtonDialog(
          context,
          null,
          StringUtils.signinDialogMsg,
          null, bottomSheetCancel,
          null, bottomSheetConfirm);
    }
  }

  /// 비밀번호 입력 화면으로 이동
  Future nextPwInput() async {
    Map args = {'email': '${_emailController.text}'};
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SignInPwScreen(args: args)));
  }

  /// 회원가입 화면으로 이동
  Future nextSignUpInput() async {
    Map args = {'email': '${_emailController.text}'};
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpScreen(args: args)));
  }
}
