import 'package:check_attendance_professor/model/attendance_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AttendanceManagementViewModel {

  // 추후 특정 과목만을 선택했을 때 혹은 검색 옵션이 있다면 인자를 추가해야 할 수 있다.


  /// AttendanceManagementViewModel의 private 생성자이다.
  ///
  /// 실제 생성에 필요한 기능을 이곳에 정의한다.
  AttendanceManagementViewModel._privateConstructor();

  /// 교수용 앱에서 데이터베이스와의 작업을 처리하기 위한 뷰모델의 생성자이다.
  /// 로그인 정보만을 이용하여 데이터베이스 쿼리를 진행하므로 별도의 인자가 필요하지 않다.
  ///
  ///
  /// ```dart
  ///   AttendanceManagementViewModel viewModel = AttendanceManagementViewModel();
  ///```
  factory AttendanceManagementViewModel() => AttendanceManagementViewModel._privateConstructor();

  /// 로그인 한 교수의 과목을 수강하는 학생들의 출결 정보를 가져오는 메서드이다.
  ///
  /// 만약 쿼리 결과가 존재하지 않으면 null을 반환한다.
  /// 이때, 로그인 한 교수의 과목 출결 정보 이외의 출결 기록은 가져오지 않는다.
  ///
  /// 이 메서드는 데이터베이스로부터 데이터를 로드해야 하므로 FutureBuilder를 사용해야 한다.
  Future<List<AttendanceInformation>?> loadAttendanceDB() async {
    // 데이터베이스는 모든 과목과 모든 학생의 출결 기록을 담은 데이터베이스가 존재하나, 학생과 교수 저장용이 별개로 존재한다.
    // 교수 저장용은 학생 저장용 데이터베이스에 접근이 가능하다.

    // if (kDebugMode) {
    //   return Future.delayed(const Duration(seconds: 1)).then((value) => [
    //         AttendanceInformation(
    //             documentId: 'documentId',
    //             subjectName: 'subjectName',
    //             studentName: 'studentName',
    //             studentID: 'studentID',
    //             result: AttendanceResult.normal,
    //             dateTime: DateTime.now())
    //       ]);
    // }

    // 교수 저장용 데이터베이스 로드
    var db = FirebaseFirestore.instance
        .collection('attendance_history')
        .doc('professor');

    // 현재 로그인 된 교수의 ID 가져오기
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // 결과를 반환할 List<AttendanceInformation>
      List<AttendanceInformation> attendanceHistory = [];

      // 교수 저장용 출결 기록
      await db.collection(currentUser.uid).get().then((event) {
        attendanceHistory = event.docs
            .map((doc) => AttendanceInformation.fromJson(documentId: doc.id, json: doc.data()))
            .toList();
      }).onError((error, stackTrace) {
        throw Exception(error);
      });

      return attendanceHistory;
    } else {
      return null;
    }
  }

  /// 선택한 학생의 출결 정보를 수정하는 메서드이다.
  ///
  /// 출결 정보를 바꾸고 싶으면 출결기록 객체 [studentHistory]와 바꾸고 싶은 상태 [editResult]를 넘겨
  /// 데이터베이스의 데이터를 수정한다.
  ///
  /// 해당 메서드를 사용해 데이터를 수정한 이후 setState()를 호출하여 갱신을 한다.
  ///
  /// 이때, [editAttendanceInformation] 메서드는 Future<void>를 반환하므로 [FutureBuilder]를 사용해야 한다.
  Future<void> editAttendanceInformation(
      AttendanceInformation studentHistory,
      AttendanceResult editResult) async {

    var db = FirebaseFirestore.instance;
    var targetHistory = studentHistory.documentId;
    var currentUser = FirebaseAuth.instance.currentUser;

    // 인자로 받은 출결기록 객체의 문서 ID를 참조해 수정할 데이터를 찾는다.
    if (currentUser!=null){
      return await db
          .collection('attendance_history')
          .doc('professor')
          .collection(currentUser.uid)
          .doc(targetHistory)
          .update({'result': editResult.name});
    } else{
      throw Exception('로그인 된 사용자가 존재하지 않습니다.');
    }
  }
}