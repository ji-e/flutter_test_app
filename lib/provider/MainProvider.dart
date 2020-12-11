

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertestapp/api/MainApi.dart';
import 'package:fluttertestapp/model/JW3001.dart';

class MainProvider with ChangeNotifier{
  final api = MainApi();

  Future<JW3001> jw3001(Map dataMap) async {
    final apiResult = await api.mainRequestService(dataMap);
    return apiResult.fold((l) {
      return null;
    }, (r) {
      final resbody = JW3001.fromJson(jsonDecode(r));
      return (resbody);
    });
  }
}