import 'dart:isolate';

class LogUtils {
  final StackTrace _trace;
  String fileName;
  int lineNumber;

  LogUtils(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = this._trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");

    this.fileName = listOfInfos[0];
    this.lineNumber = int.parse(listOfInfos[1]);
  }

  void d(dynamic) {
    var date = DateTime.now().toUtc();
    var now = date.toLocal().toLocal();

    print('$now: $fileName: $lineNumber: $dynamic');
  }
}
