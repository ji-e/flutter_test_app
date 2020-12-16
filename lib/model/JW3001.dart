import 'package:fluttertestapp/model/BaseResBody.dart';

class JW3001 extends BaseResBody {
  var successYn;
  List employeeList;

  JW3001({
    this.successYn,
    this.employeeList,
  });

  static JW3001 fromJson(Map<String, dynamic> json) {
    var resbody = json['resbody'];
    var employeeList = resbody['employeeList'] as List;
    List _employeeList = employeeList
        .map((employeeJson) => EmployeeList.fromJson(employeeJson))
        .toList();
    return resbody != null
        ? JW3001(
            successYn: resbody['successYn'],
            employeeList: _employeeList) // todo
        : null;
  }
}

class EmployeeList {
  var id;
  var profileImage; // 프로필사진
  var name; // 이름
  var phoneNumber; // 핸드폰번호
  var birth; // 생년월일
  var enteredDate; // 입사일
  var totalVacationCnt; // 총휴가일수
  var useVacation;
  var useVacationCnt;

  EmployeeList(
      this.id,
      this.profileImage,
      this.name,
      this.phoneNumber,
      this.birth,
      this.enteredDate,
      this.totalVacationCnt,
      this.useVacation,
      this.useVacationCnt);

  static EmployeeList fromJson(dynamic json) {
    return EmployeeList(
        json['_id'],
        json['profile_image'],
        json['name'],
        json['phone_number'],
        json['birth'],
        json['entered_date'],
        json['total_vacation_cnt'],
        json['use_vacation'],
        json['use_vacation_cnt']);
  }
}
