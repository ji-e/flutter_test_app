import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/views/customviews/CustomBottomDialog.dart';
import 'package:fluttertestapp/provider/SignInProvider.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:fluttertestapp/views/customviews/CustomLoading.dart';
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

  bool isLoading = false;

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
        title: Text(StringUtils.signin_title,
            style: TextStyle(color: ColorUtils.c_000000)),
      ),
      body: Form(
          key: _formEmail,
          child: Stack(children: <Widget>[
            Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView(children: <Widget>[
                  _emailEdit(),
                  _signInButton(),
                ])),
            isLoading ? CustomLoading() : Container(),
          ])),
    );
  }

  Widget _emailEdit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: StringUtils.signin_email,
            hintText: StringUtils.signin_email_hint),
        validator: (value) {
          if (!RegExp(Constants.EMAIL_PATTERN).hasMatch(value))
            return StringUtils.signin_email_err;
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
    var top = MediaQuery.of(context).viewInsets.bottom;

    return Container(
        margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: isBtnValid()
              ? () async {
                  onContinue();
                }
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ColorUtils.c_004680,
          textColor: ColorUtils.c_ffffff,
          disabledColor: ColorUtils.c_e6e6e6,
          child: Text(StringUtils.signin_btn_continue),
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

  void onContinue() async {
    FocusManager.instance.primaryFocus.unfocus();
    setState(() => isLoading = true);

    Map dataMap = {
      "methodid": Constants.JW1001,
      "email": "${_emailController.text}"
    };

    final reqData = await signInProvider.jw1001(dataMap);

    setState(() => isLoading = false);

    if (reqData == null) {
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
              StringUtils.notice,
              StringUtils.signin_network_msg,
              null,
              null,
              StringUtils.btn_confrim,
              bottomSheetCancel,
            );
          },
          isDismissible: false,
          enableDrag: false);
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
                StringUtils.notice,
                StringUtils.signin_dialog_msg,
                StringUtils.btn_cancel,
                bottomSheetCancel,
                StringUtils.btn_confrim,
                bottomSheetConfirm);
          },
          isDismissible: false,
          enableDrag: false);
    }
  }

  Future nextPwInput() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignInPwScreen()));
  }

  Future nextSignUpInput() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
