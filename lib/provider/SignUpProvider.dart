

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertestapp/api/SignUpApi.dart';
import 'package:fluttertestapp/model/JW1002.dart';

class SignUpProvider with ChangeNotifier{
  final api = SignUpApi();

  Future<JW1002> jw1002(Map dataMap) async {
    final apiResult = await api.signUpRequestService(dataMap);
    return apiResult.fold((l) {
      return null;
    }, (r) {
      final resbody = JW1002.fromJson(jsonDecode(r));
      return (resbody);
    });
  }
}