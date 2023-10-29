import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SubjectSettingsViewModel {
  // 싱글톤 패턴 부분
  
  /// 출결 유효시간을 설정하기 위한 int 타입의 변수.
  ///
  /// 뷰모델을 사용하기 위해선 반드시 validTime을 넘겨주어야 한다.
  int validTime;

  ///
  static final SubjectSettingsViewModel _instance = SubjectSettingsViewModel._privateConstructor(validTime: 0);

  /// factory 키워드를 이용한 뷰모델의 생성자이다.
  ///
  /// 과목 설정을 위한 뷰모델로 출결 유효시간 변경, 과목 삭제 등을 담당한다.
  ///
  /// 최초 호출 시 객체를 생성하며, 다시 객체 생성을 시도할 경우 최초 생성한 객체를 반환해 준다.
  factory SubjectSettingsViewModel({required int validTime}) {
    _instance.validTime = validTime;
    return _instance;
  }

  /// 뷰모델을 최초로 호출할 경우 객체를 생성하는 private 생성자이다.
  SubjectSettingsViewModel._privateConstructor({required this.validTime});
  
  // ----------------------
  
  // 메서드 부분

  void updateValidTime(int validTime) {
    // final docRef = FirebaseFirestore.instance.collection('collectionPath')
    // FirebaseFirestore.instance.collection(collectionPath)
  }
}