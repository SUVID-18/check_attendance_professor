import 'dart:convert';

import 'package:check_attendance_professor/model/attendance_information.dart';
import 'package:check_attendance_professor/model/lecture.dart';
import 'package:check_attendance_professor/model/professor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('강의 정보 객체 테스트', () {
    test('강의 객체가 정상적으로 생성되는지 테스트', () {
      const lecture = Lecture(
          id: '18000000',
          name: 'Flutter의 개발과 이해',
          department: '컴퓨터학부',
          major: '컴퓨터SW',
          room: 'IT 000호',
          professorId: '18000000',
          dayWeek: 1,
          startLesson: '11:15:00.000000',
          endLesson: '13:20:00.000000',
          validTime: 20);
      expect(lecture.name, 'Flutter의 개발과 이해');
    });
    test('강의 객체의 직렬화 테스트', () {
      const lecture = Lecture(
          id: '18000000',
          name: 'Flutter의 개발과 이해',
          department: '컴퓨터학부',
          major: '컴퓨터SW',
          room: 'IT 000호',
          professorId: '18000000',
          dayWeek: 1,
          startLesson: '11:15:00.000000',
          endLesson: '13:20:00.000000',
          validTime: 20);
      final jsonData = jsonEncode(lecture);
      expect(lecture.id, Lecture.fromJson(jsonDecode(jsonData)).id);
    });
  });
  group('출결 여부를 가진 객체 테스트', () {
    test('출결 여부를 가진 객체가 생성되는지 테스트', () {
      var attendanceInfo = AttendanceInformation(
          subjectName: '프로그래밍 언어론',
          professorName: '조영일',
          attendanceDate: DateTime.fromMillisecondsSinceEpoch(
              (1683786093.239928 * 1000).toInt()),
          result: AttendanceResult.normal);
      expect(attendanceInfo.subjectName, '프로그래밍 언어론');
    });
  });
  group('강의자 객체 테스트', () {
    test('강의자 정보에 해당되는 객체가 생성되는지 테스트', () {
      const professor = Professor('0000000', 'test');
      expect(professor.name, 'test');
    });
    test('강의자 정보 직렬화 테스트', () {
      const professor = Professor('0000000', 'test');
      final jsonData = jsonEncode(professor);
      expect(professor.id, Professor.fromJson(jsonDecode(jsonData)).id);
    });
  });
}
