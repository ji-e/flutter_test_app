
import 'package:fluttertestapp/model/BaseResBody.dart';

class JW1001 extends BaseResBody{

   var resbody;

  JW1001({this.resbody});

  static JW1001 fromJson(Map<String, dynamic> json){
    return JW1001(
      resbody: json['resbody']
    );
  }

}
