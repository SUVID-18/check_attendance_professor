import 'package:flutter/foundation.dart';

// 데이터베이스에 저장된 수업 시작시간과 종료시간은 milliseconds로 저장되어 있다고 가정하였음.

/// 과목 정보에 대한 정보를 가지고 있는 클래스
@immutable
class Subject {

  /// 과목이 배정된 요일.
  ///
  /// 요일이 int형으로 저장되어 있으므로 daytoString() 메서드를 사용하여 String 변환을 한다.
  final int dayWeek;

  /// 과목 학부 분류
  final String department;

  /// 과목이 끝나는 시간
  final String endAt;

  /// 과목코드
  final String subjectID;

  /// 과목 전공 분류
  final String major;

  /// 과목 이름
  final String subjectName;

  // 과목 담당 교수의 교번
  final String professorID;

  /// 과목이 시작하는 시간
  final String startAt;

  /// 출결을 위해 태그해야 하는 NFC 태그의 UUID.
  ///
  /// 태그 테이블에 UUID와 강의실을 같이 저장한다. 강의실 정보는 쿼리를 통해 얻을 수 있다.
  final String tagUuid;

  /// 태그 유효 시간. 단위는 분.
  ///
  /// 강의 시작시간으로부터 태그 유효 시간 안에 출석해야 출결이 인정된다.
  final int validTime;

  /// 과목 정보를 담고 있는 객체를 생성한다.
  ///
  /// Firestore로부터 넘겨받는 정보를 받는 처리하는 모델로, fromJson 메서드를 이용해 역직렬화를 수행한다.
  ///
  /// 요일은 int 값으로 출력되므로, DaytoString 메서드를 사용하여 String으로 변환하도록 한다.
  const Subject(
      {required this.dayWeek,
      required this.department,
      required this.endAt,
      required this.subjectID,
      required this.major,
      required this.subjectName,
      required this.professorID,
      required this.startAt,
      required this.tagUuid,
      required this.validTime});

  // 만약 처리할 필요가 없거나 Function에서 처리한다면 해당 메서드는 필요 없을 것으로 보임.

  /// 과목 하위 속성인 요일을 String 형으로 변환해 주는 메서드.
  ///
  /// 기존에 저장된 값은 int 형으로, 요일 간 계산을 편하게 하기 위함이었다.
  /// 이 메서드는 1,2..7 과 같은 값을 월,화..일로 변환하는 기능을 한다.
  String daytoString(){
    switch(dayWeek){
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
      default:
        throw Exception('유효하지 않은 요일입니다.');
    }
  }

  /// [json]에서 객체를 역직렬화 하는 경우(출결 여부를 가진 객체로 가져오기) 사용되는 `factory` 생성자
  ///
  /// `Firestore`에서 받은 데이터를 [Subject]객체로 반환하는 메서드로 [json]에
  /// `Firestore`에서 받은 데이터를 넣으면 된다.
  ///
  factory Subject.fromJson(Map<String, dynamic> json) {

      return Subject(
          dayWeek: json['day_week'].toInt(),
          department: json['department'],
          endAt: json['end_at'],
          subjectID: json['id'],
          major: json['major'],
          subjectName: json['name'],
          professorID: json['professor_id'],
          startAt: json['start_at'],
          tagUuid: json['tag_uuid'],
          validTime: json['valid_time']
      );
  }
}