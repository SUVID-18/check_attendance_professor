import 'package:check_attendance_professor/model/professor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///설정 페이지의 동작을 담당하는 클래스
class SettingsViewModel {
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
  ///        viewModel.signOut()
  ///            .then((_) {
  ///          print('로그아웃 됨');
  ///          context.push('/');
  ///        });
  ///    },
  ///    child: Text('Next'))
  ///```
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// 로그인 페이지의 동작을 담당하는 클래스의 생성자
  ///
  /// 로그인 페이지에서 필요한 부분에 대입시키면 된다.
  ///
  ///
  /// ```dart
  /// var viewModel = SettingsViewModel();
  ///
  ///```
  factory SettingsViewModel() => SettingsViewModel._init();

  SettingsViewModel._init() {
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
