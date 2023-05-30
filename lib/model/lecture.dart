import 'package:flutter/foundation.dart';

/// 강의에 대한 정보를 가지고 있는 클래스
@immutable
class Lecture {
  /// 강의 번호
  final String id;

  /// 강의명
  final String name;

  /// 강의 수강 대상 학부
  final String department;

  /// 강의 수강 대상 학과
  final String major;

  /// 강의실
  final String room;

  /// 강의를 가르치는 교수의 번호
  final String professorId;

  /// 강의 진행 요일(0: 월요일, 6: 일요일)
  final int dayWeek;

  /// 시작 교시
  final String startLesson;

  /// 종료 교시
  final String endLesson;

  /// 출석 유효 시간(분단위)
  final int validTime;

  /// 강의 정보에 관한 객체를 생성한다.
  ///
  /// [id]에는 강의의 번호를 [name]에는 강의 이름을
  /// 넣는 식으로 강의 객체를 생성한다. 매개변수별 설명은 커서에 올리면
  /// 표시된다.
  const Lecture(
      {required this.id,
      required this.name,
      required this.department,
      required this.major,
      required this.room,
      required this.dayWeek,
      required this.professorId,
      required this.startLesson,
      required this.endLesson,
      required this.validTime});

  /// [json]에서 객체를 역직렬화 하는 경우(강의 객체로 가져오기) 사용되는 `factory` 생성자
  ///
  /// `Firestore`에서 받은 데이터를 [Lecture]객체로 반환하는 메서드로 [json]에
  /// `Firestore`에서 받은 데이터를 넣으면 된다.
  ///
  /// ```dart
  /// final lectureRef = db.collection('lectures').doc('test');
  /// lectureRef.get().then(
  ///   (DocumentSnapshot doc) {
  ///     final student = Lecture.fromJson(jsonDecode(doc.data()));
  ///    },
  ///    onError: (e) => print('Error Detected: $e'),
  ///   );
  /// ```
  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
      id: json['id'],
      name: json['name'],
      department: json['department'],
      major: json['major'],
      room: json['room'],
      professorId: json['professor_id'],
      dayWeek: json['day_week'],
      startLesson: json['start_at'],
      endLesson: json['end_at'],
      validTime: json['valid_time']);

  /// 객체를 `JSON`으로 직렬화 하는 메서드
  ///
  /// 객체를 `Firestore`에게 쉽게 올릴 수 있도록 직렬화를 수행한다.
  /// 이 메서드는 별도로 호출될 필요 없이 `jsonEncode()`메서드에 사용된다.
  ///
  /// ```dart
  /// String json = jsonEncode(lecture);
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'department': department,
        'major': major,
        'room': room,
        'professor_id': professorId,
        'day_week': dayWeek,
        'start_at': startLesson,
        'end_at': endLesson,
        'valid_time': validTime
      };
}
