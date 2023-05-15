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

  /// 문서 ID
  final String professorName;

  /// 출결 일시
  final DateTime attendanceDate;

  /// 출결 여부
  final AttendanceResult result;

  /// 출결 여부를 가진 객체를 생성한다.
  ///
  /// [subjectName]에 과목 이름을 넣고, [professorName]에 교수나 강의자 이름을 넣고
  /// [result]에 [AttendanceResult]를 통해 출결 여부를 넣으면 된다.
  ///
  /// 만일 [result]가 `AttendanceResult.normal`인
  /// 경우 출결한 것으로 간주한다.
  const AttendanceInformation(
      {required this.subjectName,
      required this.professorName,
      required this.attendanceDate,
      required this.result});

  /// [json]에서 객체를 역직렬화 하는 경우(출결 여부를 가진 객체로 가져오기) 사용되는 `factory` 생성자
  ///
  /// `Firestore`에서 받은 데이터를 [AttendanceInformation]객체로 반환하는 메서드로 [json]에
  /// `Firestore`에서 받은 데이터를 넣으면 된다.
  ///
  /// ```dart
  /// final lectureRef = db.collection('attendances').doc('test');
  /// lectureRef.get().then(
  ///   (DocumentSnapshot doc) {
  ///     final student = AttendanceInformation.fromJson(jsonDecode(doc.data()));
  ///    },
  ///    onError: (e) => print('Error Detected: $e'),
  ///   );
  /// ```
  factory AttendanceInformation.fromJson(Map<String, dynamic> json) =>
      AttendanceInformation(
          subjectName: json['subject_name'],
          professorName: json['professor_name'],
          attendanceDate: DateTime.fromMillisecondsSinceEpoch(
              (json['timestamp'] * 1000).toInt()),
          result: AttendanceResult.values.byName(json['result']));
}
