import 'package:flutter/foundation.dart';

/// 출결 여부에 대한 결과를 나타내는 열거형
///
/// [absent]는 결석을, [normal]은 정상 출결을
/// [tardy]는 지각을 의미한다.
enum AttendanceResult {
  /// 결석
  absent,

  /// 정상 출결
  normal,

  /// 지각
  tardy;

  @override
  String toString() {
    switch (this) {
      case AttendanceResult.absent:
        return '결석';
      case AttendanceResult.normal:
        return '출석';
      case AttendanceResult.tardy:
        return '지각';
    }
  }
}

/// 출결 여부에 대한 정보를 가지고 있는 클래스
@immutable
class AttendanceInformation {
  /// 과목의 이름
  final String subjectName;

  /// 학생의 이름
  final String studentName;

  /// 학생 학번
  final String studentID;

  /// timestamp

  /// 출결 여부
  final AttendanceResult result;

  /// 출석 당시의 날짜와 시간
  final DateTime dateTime;


  /// 출결 여부를 가진 객체를 생성한다.
  ///
  /// Firestore로부터 넘겨받는 정보를 받는 처리하는 모델로 fromJson 메서드를 이용해 역직렬화를 수행한다.
  /// [Timestamp]형으로 저장된 출석 시간은 모델에서 [DateTime]형으로 변환하여 저장한다.
  const AttendanceInformation(
      {required this.subjectName, required this.studentName, required this.studentID,
        required this.result, required this.dateTime});

  /// [json]에서 객체를 역직렬화 하는 경우(출결 여부를 가진 객체로 가져오기) 사용되는 `factory` 생성자
  ///
  /// `Firestore`에서 받은 데이터를 [AttendanceInformation]객체로 반환하는 메서드로 [json]에
  /// `Firestore`에서 받은 데이터를 넣으면 된다.
  ///
  /// 이 때, Firestore에 저장된 timestamp 필드는 millisecond 단위여야 한다.
  factory AttendanceInformation.fromJson(Map<String, dynamic> json) =>
      AttendanceInformation(
          subjectName: json['subject_name'],
          studentName : json['student_name'],
          studentID : json['student_id'],
          result: AttendanceResult.values.byName(json['result']),
          dateTime: DateTime.fromMillisecondsSinceEpoch((json['timestamp']).toInt()*1000));
}

