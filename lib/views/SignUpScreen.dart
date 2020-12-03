import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _formEmail = GlobalKey<FormState>();

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
            labelText: "이메일입력",
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
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: isBtnValid()
              ? () async {

                }
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ColorUtils.c_004680,
          textColor: ColorUtils.c_ffffff,
          disabledColor: ColorUtils.c_e6e6e6,
          child: Text("계속하기"),
        ));
  }

  bool isBtnValid() {

    if (_emailController.text.isEmpty) {
      return false;
    }
    return _formEmail.currentState.validate();
  }


  Future nextSignUp() async{
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SignUpScreen()));
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
