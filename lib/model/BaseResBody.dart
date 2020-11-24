class BaseResBody {
  final String timestamp;
  final String txid;
  final String result;
  final String errCode;
  final String msg;


  BaseResBody({this.timestamp, this.txid, this.result, this.errCode, this.msg});

  factory BaseResBody.fromJson(Map<String, dynamic> json){
    return BaseResBody(
        timestamp: json['timeStamp'],
        txid: json['txid'],
        result: json['result'],
        errCode: json['errCode'],
        msg: json['msg']
    );
  }
}