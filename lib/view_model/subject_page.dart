import 'package:check_attendance_professor/model/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubjectPageViewModel{
  // 추후 특정 과목만을 선택했을 때 혹은 검색 옵션이 있다면 인자를 추가해야 할 수 있다.
  
  // 싱글톤 패턴 선언부

  /// SubjectPageViewModel의 private 생성자이다.
  ///
  /// 실제 생성에 필요한 기능을 이곳에 정의한다.
  SubjectPageViewModel._privateConstructor();

  /// 교수용 앱에서 데이터베이스와의 작업을 처리하기 위한 뷰모델의 생성자이다.
  /// 로그인 정보만을 이용하여 데이터베이스 쿼리를 진행하므로 별도의 인자가 필요하지 않다.
  ///
  ///
  /// ```dart
  ///   SubjectPageViewModel viewModel = SubjectPageViewModel();
  ///```
  factory SubjectPageViewModel() => SubjectPageViewModel._privateConstructor();
  
  
  /// 교수 본인이 가르치는 과목 목록을 불러오는 메서드이다.
  ///
  /// 교수 이름이 아닌 교번으로 분류하므로 동명이인일 경우는 고려하지 않아도 된다.
  /// 만약 쿼리 결과가 존재하지 않으면 null을 반환한다.
  ///
  /// 이 메서드는 데이터베이스로부터 데이터를 로드해야 하므로 FutureBuilder를 사용해야 한다.
  Future<List<Subject>?> loadSubjectDB() async {
    // if (kDebugMode) {
    //   return Future.delayed(const Duration(seconds: 1)).then((_) => [
    //         const Subject(
    //             dayWeek: 0,
    //             department: '컴퓨터 학부',
    //             endAt: '23:20:00.000000',
    //             subjectID: 'SDy1h3thCVdCu1r5DxPx',
    //             major: '컴퓨터SW',
    //             subjectName: 'Firebase를 활용한 플랫폼 개발 1',
    //             professorID: '0001010',
    //             startAt: '15:50:00.000000',
    //             tagUuid: '62ad5800-4d36-4dcf-b5eb-4a26a1503a74',
    //             validTime: 20),
    //         const Subject(
    //             dayWeek: 0,
    //             department: '컴퓨터 학부',
    //             endAt: '23:20:00.000000',
    //             subjectID: 'SDy1h3thCVdCu1r5DxPx',
    //             major: '컴퓨터SW',
    //             subjectName: 'Firebase를 활용한 플랫폼 개발 2',
    //             professorID: '0001010',
    //             startAt: '15:50:00.000000',
    //             tagUuid: '62ad5800-4d36-4dcf-b5eb-4a26a1503a74',
    //             validTime: 20),
    //         const Subject(
    //             dayWeek: 0,
    //             department: '컴퓨터 학부',
    //             endAt: '23:20:00.000000',
    //             subjectID: 'SDy1h3thCVdCu1r5DxPx',
    //             major: '컴퓨터SW',
    //             subjectName: 'Firebase를 활용한 플랫폼 개발 3',
    //             professorID: '0001010',
    //             startAt: '15:50:00.000000',
    //             tagUuid: '62ad5800-4d36-4dcf-b5eb-4a26a1503a74',
    //             validTime: 20),
    //       ]);
    // }

    // 데이터베이스로부터 과목 목록을 불러옴.
    var db = FirebaseFirestore.instance;

    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      List<Subject>? subjectList = [];

      // 로그인한 사용자의 교번. 이 교번을 이용해 과목에서 쿼리한다.
      final queryMyID =
      await db.collection('professors').doc(currentUser.uid).get();

      // 이 부분을 추후 교수 객체로 변경할 수 있음.
      // 이미 사용자가 있다고 검사했으므로 반드시 null이 아닐 것임.
      final myID = queryMyID.data()!['id'];

      // 교수 본인이 가르치는 과목을 쿼리한다.
      final queryInSubjectDB =
          db.collection('subjects').where('professor_id', isEqualTo: myID);

      await queryInSubjectDB.get().then((event) {
        // 담당한 과목이 있을 경우에만
        if (event.docs.isNotEmpty) {
          subjectList =
              event.docs.map((doc) => Subject.fromJson(doc.data())).toList();
        } else {
          throw Exception('현재 담당하고 있는 과목이 존재하지 않습니다.');
        }
      });

      return subjectList;
    } else {
      return null;
    }
  }
}