import 'package:check_attendance_professor/model/professor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///설정 페이지의 동작을 담당하는 클래스
class SettingsViewModel {
  final BuildContext context;

  /// 강의자의 정보
  late Professor professorInfo;

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

  SettingsViewModel._init(this.context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    try {
      var database = FirebaseFirestore.instance
          .collection('professors')
          .doc(currentUser?.uid);
      database.get().then((value) {
        professorInfo = Professor.fromJson(value.data()!);
      });
    } catch (_) {
      professorInfo = const Professor('unknwon', '(등록 안됨)');
    }
  }
}
