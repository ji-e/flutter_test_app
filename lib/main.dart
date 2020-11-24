import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertestapp/Utils/ColorUtils.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/provider/SignUpProvider.dart';
import 'package:fluttertestapp/views/IntroScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark));

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
        ],
        child: MaterialApp(
            title: 'Api Calls like a Legend with Provider',
            theme: ThemeData(primaryColor: ColorUtils.ffffffColor),
            home: IntroScreen()));
//    return MultiProvider(
//        providers: [
//          ChangeNotifierProvider(create: (context) => SignInProvider()),
//          ChangeNotifierProvider(create: (context) => SignUpProvider())
//        ],
//        child: MaterialApp(
//          title: 'Flutter Demo',
//          theme: ThemeData(primaryColor: ColorUtils.ffffffColor),
//          home: IntroScreen(),
//        ));
  }
  @override
  void dispose() {
    super.dispose();
  }
}
