import 'package:fluttertestapp/model/BaseResBody.dart';

class JW2001 extends BaseResBody {
  var signInValid;
  var autoToken;

  JW2001({this.signInValid, this.autoToken});

  static JW2001 fromJson(Map<String, dynamic> json) {
    var resbody = json['resbody'];
    return resbody != null
        ? JW2001(
            signInValid: resbody['signInValid'],
            autoToken: resbody['autoToken'])
        : null;
  }
}
