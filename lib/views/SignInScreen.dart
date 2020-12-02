import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/customviews/CustomBottomDialog.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:provider/provider.dart';

import 'SignInPwScreen.dart';
import 'SignUpScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _formEmail = GlobalKey<FormState>();

  BuildContext _bottomSheetBuildContext;

  SignInProvider signInProvider;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtils.c_ffffff,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('로그인', style: TextStyle(color: ColorUtils.c_000000)),
      ),
      body: Form(
          key: _formEmail,
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: <Widget>[
                    _emailEdit(),
                    _signInButton(),
                  ])

//        floatingActionButton: FloatingActionButton(
//        onPressed:()=>signInProvider.jw1001("jieun1@naver.com"),
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
                  ))),
    );
  }

  Widget _emailEdit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 80, 0, 60),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "이메일",
            hintText: "이메일을 입력해주세요"),
        validator: (value) {
          if (!RegExp(Constants.EMAIL_PATTERN).hasMatch(value))
            return '이메일 형식으로 입력해주세요.';
          return null;
        },
        onChanged: (value) {
          setState(() {});
          _formEmail.currentState.validate();
        },
      ),
    );
  }

  Widget _signInButton() {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, bottom),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: isBtnValid()
              ? () async {
                  Map dataMap = {
                    "methodid": "JW1001",
                    "email": "${_emailController.text}"
                  };
                  final reqData = await signInProvider.jw1001(dataMap);

                  if (reqData == null) {
                    return;
                  }

                  String emailValid = reqData.emailValid.toString();
                  if ("Y" == emailValid) {
                    nextPwInput();
                  } else if ("N" == emailValid) {
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
                              "알림",
                              '등록된 이메일이 없습니다.\n회원가입 하시겠습니까?',
                              '취소',
                              bottomSheetCancel,
                              '확인',
                              bottomSheetConfirm);
                        },
                        isDismissible: false,
                        enableDrag: false);
//
                  }

                  LogUtils(StackTrace.current).d(reqData);
//                  var email = reqData.email;
//                  LogUtils(StackTrace.current).d(email);
                }
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ColorUtils.c_004680,
          textColor: ColorUtils.c_ffffff,
          disabledColor: ColorUtils.c_e6e6e6,
          child: Text("계속하기"),
        ));
  }

  bottomSheetCancel() {
    Navigator.pop(_bottomSheetBuildContext);
  }

  bottomSheetConfirm() {
    Navigator.pop(_bottomSheetBuildContext);
    nextSignUpInput();
  }

  bool isBtnValid() {
    if (_emailController.text.isEmpty) {
      return false;
    }
    return _formEmail.currentState.validate();
  }

  Future nextPwInput() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignInPwScreen()));
  }

  Future nextSignUpInput() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

//  Widget _pwEdit() {
//    return TextField(
//      obscureText: true,
//      decoration: InputDecoration(
//          border: OutlineInputBorder(),
//          labelText: "비밀번호",
//          hintText: "비밀번호를 입력해주세요"),
//    );
//  }
}
