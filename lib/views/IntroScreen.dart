
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignInScreen.dart';

// 임시

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreen();
}

class _IntroScreen extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      nextEmailInput();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('images/logo.png')
                ),
                Text('주원산업')
              ],
            )
        )
    );

  }

  Future nextEmailInput() async{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}