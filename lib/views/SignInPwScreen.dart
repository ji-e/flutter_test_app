import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:provider/provider.dart';

class SignInPwScreen extends StatefulWidget {
  @override
  _SignInPwScreen createState() => _SignInPwScreen();
}

class _SignInPwScreen extends State<SignInPwScreen> {
  final _pwController = TextEditingController();
  final _formEmail = GlobalKey<FormState>();

  SignInProvider signInProvider;

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
        title: Text('로그인', style: TextStyle(color: ColorUtils.c_000000)),
      ),
      body: Form(
          key: _formEmail,
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: <Widget>[
                    _pwEdit(),
                    _signInButton(),
                  ])

//        floatingActionButton: FloatingActionButton(
//        onPressed:()=>signInProvider.jw1001("jieun1@naver.com"),
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
                  ))),
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
            labelText: "비밀번호",
            hintText: "비밀번호를 입력해주세요"),
        validator: (value) {
          if (value.length < 8) return '8자 이상 입력해주세요.';
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
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: isBtnValid()
              ? () async {
//                  final reqData = await signInProvider.jw1001(_emailController.text);
//
//                  if(reqData == null){
//
//                    return;
//                  }
//
//
//                  LogUtils(StackTrace.current).d(reqData);
//                  var email = reqData.email;
//                  LogUtils(StackTrace.current).d(email);
                }
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ColorUtils.c_004680,
          textColor: ColorUtils.c_ffffff,
          disabledColor: ColorUtils.c_e6e6e6,
          child: Text("로그인"),
        ));
  }

  bool isBtnValid() {
    return _pwController.text.length >= 8;
  }

  Future nextSignIn() async {
//    Navigator.of(context).push(
//        MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
