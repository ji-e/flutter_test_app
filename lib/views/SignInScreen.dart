import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
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
        backgroundColor: ColorUtils.c_ffffff,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('로그인', style: TextStyle(color: ColorUtils.c_000000)),
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                  children: <Widget>[_emailEdit(),_signInButton(), ])

//        floatingActionButton: FloatingActionButton(
//        onPressed:()=>signInProvider.jw1001("jieun1@naver.com"),
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
          )),
    );
  }

  Widget _signInButton() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        height: 60,
        width: MediaQuery.of(context).size.width,

        child:  RaisedButton(
          onPressed: () async {
            // todo
            final reqData = signInProvider.jw1001("jieun1@naver.com");
            print("$reqData" + "FDFDdfdfsdfsf");
          },
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(4)),
          color: ColorUtils.c_004680,
          textColor: ColorUtils.c_ffffff,
          child: Text("계속하기"),
//          child: Icon(Icons.add),
        )
    );
  }

  Widget _emailEdit() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 80, 0, 10),
        height: 50,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "이메일입력",
              hintText: "이메일을 입력해주세요"),
        ));
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
