import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class ApiRequestBody {

  Map reqBody = {
   "timestamp":DateFormat('yyyyMMddhhmmss').format(DateTime.now().toLocal()),
    "txid":(Uuid().v1().toString()).replaceAll("-", "")
  };
}