import 'package:fluttertestapp/model/BaseResBody.dart';

class JW1002 extends BaseResBody {
  var signUpValid;

  JW1002({this.signUpValid});

  static JW1002 fromJson(Map<String, dynamic> json) {
    var resbody = json['resbody'];
    return resbody != null
        ? JW1002(signUpValid: resbody['signUpValid'])
        : null;
  }
}
