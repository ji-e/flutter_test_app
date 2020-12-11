import 'package:fluttertestapp/model/BaseResBody.dart';

class JW1001 extends BaseResBody {
  var emailValid;
  var email;

  JW1001({this.emailValid, this.email});

  static JW1001 fromJson(Map<String, dynamic> json) {
    var resbody = json['resbody'];
    return resbody != null
        ? JW1001(emailValid: resbody['emailValid'], email: resbody['email'])
        : null;
  }
}
