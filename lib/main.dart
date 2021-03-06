import 'package:flutter/material.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/MainProvider.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/provider/SignUpProvider.dart';
import 'package:fluttertestapp/views/IntroScreen.dart';
import 'package:provider/provider.dart';

void main() async {
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: Colors.white,
////      systemNavigationBarIconBrightness: Brightness.dark,
//      statusBarIconBrightness: Brightness.dark)
//  );

//  SystemChrome.setSystemUIOverlayStyle(
//      SystemUiOverlayStyle.light.copyWith(
//          statusBarColor: Colors.white,
//          statusBarBrightness: Brightness.dark));

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SignInProvider()),
          ChangeNotifierProvider(create: (context) => SignUpProvider()),
          ChangeNotifierProvider(create: (context) => MainProvider()),
        ],
        child: MaterialApp(
            title: 'Api Calls like a Legend with Provider',
            theme: ThemeData(primaryColor: ColorUtils.c_004680, accentIconTheme: IconThemeData(color: Colors.black)),
            home: IntroScreen()));
  }
  @override
  void dispose() {
    super.dispose();
  }
}
