import 'package:cloud_firestore/cloud_firestore.dart';

/// 과목 설정을 위한 기능을 구현한 뷰모델로, 과목 출결 유효시간 변경 및 과목 삭제를 수행하는 메서드가 내장되어 있다.
class SubjectSettingsViewModel {
  // 싱글톤 패턴 부분
  
  /// 출결 유효시간을 설정하기 위한 int 타입의 변수.
  ///
  /// 뷰모델을 사용하기 위해선 subjectID을 넘겨주어야 한다.
  String subjectID;

  /// factory 키워드를 이용한 뷰모델의 생성자이다.
  ///
  /// 과목 설정을 위한 뷰모델로 출결 유효시간 변경, 과목 삭제 등을 담당한다.
  ///
  /// 최초 호출 시 객체를 생성하며, 다시 객체 생성을 시도할 경우 최초 생성한 객체를 반환해 준다.
  factory SubjectSettingsViewModel({required String subjectID}) {
    return SubjectSettingsViewModel._privateConstructor(subjectID: subjectID);
  }

  /// 뷰모델을 최초로 호출할 경우 객체를 생성하는 private 생성자이다.
  SubjectSettingsViewModel._privateConstructor({required this.subjectID});
  
  // ----------------------

  /// 과목 설정 화면을 띄울 때 현재 설정된 과목 출결 유효시간을 데이터베이스로부터 가져오는 메서드이다.
  Stream<QuerySnapshot<Map<String, dynamic>>> getValidTime() {
    return FirebaseFirestore.instance
        .collection('subjects')
        .where('id', isEqualTo: subjectID)
        .snapshots();
  }

  /// 과목의 유효 시간을 업데이트 하는 메서드이다.
  Future<void> updateValidTime(int validTime) async{
    var subjectRef = await FirebaseFirestore.instance
        .collection('subjects')
        .where('id', isEqualTo: subjectID)
        .get();
    return subjectRef.docs.first.reference.update({'valid_time': validTime});
  }

  /// 과목을 삭제하는 메서드이다.
  ///
  /// 과목 삭제 후 과목 목록 페이지로 이동된다.
  Future<void> deleteSubject() async{
    var subjectRef = await FirebaseFirestore.instance.collection('subjects').where('id', isEqualTo: subjectID).get();
    return subjectRef.docs.first.reference.delete();
  }
}