import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'ApiRequestBody.dart';

class SignInApi extends ApiRequestBody{
  final url = 'https://joowon12.herokuapp.com/process/sign_p/admin';

  Future<Either<Exception, String>> jw1001(Map dataMap) async {
    try {

      dataMap.addAll(getReqBody());
      final reqbody = json.encode(dataMap);

      LogUtils(StackTrace.current).d("$reqbody");

      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: reqbody);

      LogUtils(StackTrace.current).d("${response.body.toString()}");

      return (Right(response.body.toString()));
    } catch (e) {
      LogUtils(StackTrace.current).d("$e");
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> jw2001(Map dataMap) async {
    try {

      dataMap.addAll(getReqBody());
      final reqbody = json.encode(dataMap);

      LogUtils(StackTrace.current).d("$reqbody");

      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: reqbody);

      LogUtils(StackTrace.current).d("${response.body.toString()}");

      return (Right(response.body.toString()));
    } catch (e) {
      LogUtils(StackTrace.current).d("$e");
      return (Left(e));
    }
  }
}
