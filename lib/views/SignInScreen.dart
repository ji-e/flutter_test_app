import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreen createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
   SignInProvider signInProvider;

  @override
  void initState() {
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('로그인'),
        ),
        body: SingleChildScrollView(
          child: _signInButton(),
      ),
    );
  }

  Widget _signInButton(){
    return GestureDetector(
      onTap:() async {

        final reqData =await signInProvider.jw1001("jieun1@naver.com");
        var email = reqData.email;
        LogUtils(StackTrace.current).d(email);
      },
      child: Icon(Icons.add),
    );
  }


}