import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SignInApi {
  final url = 'https://joowon12.herokuapp.com/process/sign_p/admin';

  Future<Either<Exception, String>> jw1001(String email) async {
    try {
      Map data = {"methodid": "JW1001", "email": "$email"};
      final reqbody = json.encode(data);

      print("$reqbody");

      final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: reqbody);

      print("${response.body.toString()}");

      return (Right(response.body.toString()));
    } catch (e) {
      return (Left(e));
    }
  }
}
