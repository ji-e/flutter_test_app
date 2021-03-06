import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BasePageScreen.dart';
import 'SignInScreen.dart';

// 임시

class IntroScreen extends BasePageScreen {
  @override
  State<StatefulWidget> createState() => _IntroScreen();
}

class _IntroScreen extends BasePageScreenState<IntroScreen> with BaseScreen {
  @override
  String appBarTitleText() {
    return '';
  }
  @override
  dynamic appBarTitleColor() {
    return ColorUtils.c_ffffff;
  }


  @override
  Widget body() {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50, width: 50, child: Image.asset('images/logo.png')),
                Text(StringUtils.appName)
              ],
            )));
  }


  @override
  void initState() {
    getToken();

    Future.delayed(Duration(seconds: 3), () {
      nextEmailInput();
    });
    super.initState();
  }

  Future nextEmailInput() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()));
  }
  void getToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    var token = await _firebaseMessaging.getToken();
    LogUtils(StackTrace.current).d('Instance ID: $token');

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.INSTANCE_ID, token);
  }


}
