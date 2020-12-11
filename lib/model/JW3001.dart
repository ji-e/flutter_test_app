import 'package:fluttertestapp/model/BaseResBody.dart';

class JW3001 extends BaseResBody {
  var successYn;
  var employeeList;

  JW3001({this.successYn, this.employeeList});

  static JW3001 fromJson(Map<String, dynamic> json) {
    var resbody = json['resbody'];
    return resbody != null
        ? JW3001(
        successYn: resbody['signInValid'],
        employeeList: resbody['employeeList'])  // todo
        : null;
  }
}
