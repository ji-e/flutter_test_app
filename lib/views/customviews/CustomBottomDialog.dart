import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/TextStyleUtils.dart';

class CustomBottomDialog {
  Widget buildTwoButtonBottomSheet(
      BuildContext context,
      String title,
      String msg,
      String cancel,
      var bottomSheetCancel,
      String confirm,
      var bottomSheetConfirm) {
    return Container(
        height: 250,
        child: Column(children: <Widget>[
          SizedBox(height: 15),
          Text(title, style: TextStyleUtils().f_20_000000()),
          Expanded(
              child: Center(
                  child: Text(msg,
                      textAlign: TextAlign.center,
                      style: TextStyleUtils().f_16_000000()))),
          Row(children: <Widget>[
            cancel != null
                ? Expanded(
                    child: Container(
                    height: 60,
                    child: RaisedButton(
                      onPressed: () => bottomSheetCancel(),
                      color: ColorUtils.c_e6e6e6,
                      child: Text(cancel),
                    ),
                  ))
                : Container(),
            Expanded(
                child: Container(
              height: 60,
              child: RaisedButton(
                onPressed: () => bottomSheetConfirm(),
                color: ColorUtils.c_004680,
                textColor: ColorUtils.c_ffffff,
                child: Text(confirm),
              ),
            )),
          ]),
        ]));
  }
}
