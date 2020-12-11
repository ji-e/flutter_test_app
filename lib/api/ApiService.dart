
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ApiService {
  static String SERVICE_EMPLOYEE = "employee";

  Map getReqBody() {
    var dateT = DateTime.now().toLocal();
    var uuid = Uuid().v1().toString();
    return {
      "timestamp": DateFormat('yyyyMMddhhmmss').format(dateT),
      "txid": (uuid).replaceAll("-", "")
    };
  }

  dynamic setHttp(url, reqbody) {
    return http.post(url, headers: headers, body: reqbody);
  }

  static Map<String, String> headers = {"Content-Type": "application/json"};
  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
