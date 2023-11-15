import 'package:check_attendance_professor/model/professor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///설정 페이지의 동작을 담당하는 클래스
class SettingsViewModel {
  final BuildContext context;

  /// 로그아웃 시 사용되는 메서드
  ///
  /// 로그아웃 버튼을 누를 시 수행하는 동작을 정의합니다.
  ///.
  ///
  /// ```dart
  /// ElevatedButton(
  ///    onPressed: () {
  ///        viewModel.signOut();
  ///    },
  ///    child: Text('Next'))
  ///```
  Future<void> signOut() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Row(
          children: [CircularProgressIndicator.adaptive(), Text('  로그아웃 중...')],
        ),
      ),
    );
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      context.pop();
      context.go('/');
    }
  }

  /// 강의자 정보를 반환하는 메서드
  ///
  /// 계정의 UID를 이용해서 강의자 정보가 담긴 객체를 반환하는 메서드이다.
  /// 만일 어떠한 문제로 인해 강의자 정보를 찾을 수 없는 경우 `null`을 반환한다.
  ///
  /// 해당 메서드는 인터넷 통신에 의한 대기시간이 필요하기에 [Future]형태를 띈다.
  ///
  /// ## 예제
  /// 코드가 너무 길어 생략. [FutureBuilder] 참고바람.
  ///
  /// ## 같이보기
  /// * [Professor]
  /// * [FutureBuilder]
  Future<Professor?> getProfessorInfo() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var professor = await FirebaseFirestore.instance
          .collection('professors')
          .doc(user.uid)
          .get();
      var data = professor.data();
      if (data != null) {
        return Professor.fromJson(data);
      }
    }
    return null;
  }

  /// 로그인 페이지의 동작을 담당하는 클래스의 생성자
  ///
  /// 로그인 페이지에서 필요한 부분에 대입시키면 된다.
  /// 로그아웃 시 [AlertDialog]를 출력시키기 때문에 [context]를
  /// 필요로 한다.
  ///
  ///
  /// ```dart
  /// late var viewModel = SettingsViewModel(context: context);
  ///
  ///```
  factory SettingsViewModel({required BuildContext context}) =>
      SettingsViewModel._init(context);

  SettingsViewModel._init(this.context);
}
