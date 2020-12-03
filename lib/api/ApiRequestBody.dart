import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ApiRequestBody {
  Map getReqBody() {
    var dateT = DateTime.now().toLocal();
    var uuid = Uuid().v1().toString();
    return {
      "timestamp": DateFormat('yyyyMMddhhmmss').format(dateT),
      "txid": (uuid).replaceAll("-", "")
    };
  }
}
