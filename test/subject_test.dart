import 'package:check_attendance_professor/model/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Map<String,dynamic> jsonfile = {
  'day_week': 1,
  'department': '컴퓨터학부',
  'end_at': 1683786043,
  'id': '15344',
  'major': '미디어SW',
  'name': '신비한 Rust 세계',
  'professor_id': '이정민',
  'start_at': 1683786093.239928,
  'tag_uuid': '5b342bc',
  'valid_time': 20,
  };

  test('subject 모델 테스트', () {
    final subject = Subject.fromJson(jsonfile);
    debugPrint(subject.daytoString());
    debugPrint(subject.startAt);
    debugPrint(subject.endAt);

    // endAt startAt은 dartpad를 통해 검사결과를 통과함. 실제 데이터베이스에 연동하여 test 코드를 돌릴 순 없어서.
    // 출력결과 월.
  });
}
