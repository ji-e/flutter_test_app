import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fluttertestapp/api/ApiService.dart';
import 'package:fluttertestapp/utils/LogUtils.dart';
import 'dart:async';

class MainApi extends ApiService{
  final url = 'https://joowon12.herokuapp.com/process/base/${ApiService.SERVICE_EMPLOYEE}';

  Future<Either<String, String>> mainRequestService(Map dataMap) async {
    try {
      dataMap.addAll(getReqBody());
      final reqbody = json.encode(dataMap);
      LogUtils(StackTrace.current).d('$reqbody');

      final response = await ApiService().setHttp(url, reqbody);
      LogUtils(StackTrace.current).d('${response.body.toString()}');

      updateCookie(response);
      return (Right(response.body.toString()));
    } catch (e) {
      LogUtils(StackTrace.current).d('$e');

      return (Left('$e'));
    }
  }
}
