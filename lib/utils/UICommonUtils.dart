import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/TextStyleUtils.dart';

class UICommonUtils {

  TextStyle setTextStyle(int fontSize, var color){
    return TextStyle(fontSize: fontSize.toDouble(), color: color);
  }

  ///
  InputDecoration commonInputDecoration(label, hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 15),
      border: OutlineInputBorder(),
      labelText: label,
      hintText: hint,
      counterText: ' ',
    );
  }

  ///
  RaisedButton commonRaisedButton(isBtnValid, btnOnPressed, btnText) {
    return RaisedButton(
      onPressed: isBtnValid
          ? () => btnOnPressed()
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: ColorUtils.c_004680,
      textColor: ColorUtils.c_ffffff,
      disabledColor: ColorUtils.c_e6e6e6,
      child: Text(btnText, style: TextStyleUtils().f_16_ffffff(),),
    );
  }
}