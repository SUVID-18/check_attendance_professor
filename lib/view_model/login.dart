import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// 로그인 페이지의 동작을 담당하는 클래스
class LoginViewModel {
  /// 이메일에 해당되는 [TextEditingController]
  TextEditingController get userEmailController => _userEmailController;

  /// 비밀번호에 해당되는 [TextEditingController]
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// 로그인 시 사용되는 메서드
  ///
  /// 만일 이메일, 비밀번호 중 하나라도 입력하지 않았을 경우 아무 동작도 하지 않는다.
  /// 로그인 중 어떤 상황에 의해 오류가 발생한다면 예외가 발생한다.
  ///.
  ///
  /// ```dart
  /// ElevatedButton(
  ///    onPressed: () {
  ///      try {
  ///        viewModel.signIn()
  ///            .then((_) {
  ///          print('로그인 성공');
  ///          context.push('/');
  ///        });
  ///      } catch (error) {
  ///        print('오류로 인한 로그인 실패: $error');
  ///        return;
  ///      }
  ///    },
  ///    child: Text('Next'))
  ///```
  Future<void> signIn() async {
    if (_userEmailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userEmailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// 로그인 페이지의 동작을 담당하는 클래스의 생성자
  ///
  /// 로그인 페이지에서 필요한 부분에 대입시키면 된다.
  ///
  ///
  /// ```dart
  /// var viewModel = LoginViewModel();
  ///
  ///
  ///TextField(
  ///   controller: viewModel.userEmailController,
  ///   decoration: InputDecoration(
  ///       filled: true,
  ///       labelText: 'Email'
  ///   ),
  /// ),
  ///```
  factory LoginViewModel() => LoginViewModel._init();

  LoginViewModel._init();
}
