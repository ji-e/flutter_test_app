import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertestapp/api/SignInApi.dart';
import 'package:fluttertestapp/model/JW1001.dart';
import 'package:fluttertestapp/model/JW2001.dart';


class SignInProvider with ChangeNotifier {
  final api = SignInApi();

  Future<JW1001> jw1001(Map dataMap) async {
    final apiResult = await api.signInRequestService(dataMap);
    return apiResult.fold((l) {
      return null;
    }, (r) {
      final resbody = JW1001.fromJson(jsonDecode(r));
      return (resbody);
    });
  }

  Future<JW2001> jw2001(Map dataMap) async {
    final apiResult = await api.signInRequestService(dataMap);
    return apiResult.fold((l) {
      return null;
    }, (r) {
      final resbody = JW2001.fromJson(jsonDecode(r));
      return (resbody);
    });
  }
}
