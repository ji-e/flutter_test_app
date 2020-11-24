
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertestapp/api/SignInApi.dart';
import 'package:fluttertestapp/model/JW1001.dart';

class SignUpProvider with ChangeNotifier{
  final api = SignInApi();


  Future<JW1001> jw1001(String email) async {
    final apiResult = await api.jw1001(email);
    return apiResult.fold((l) {
      return null;
    }, (r) {
      final resbody = JW1001.fromJson(jsonDecode(r));
      return (resbody);
    });
  }
}