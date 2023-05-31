import 'package:check_attendance_professor/view_model/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// viewmodel 생성자
  var viewModel = RegisterPageViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              ///viewmodel 영
              controller: viewModel.userEmailController,
              decoration: InputDecoration(
                labelText: '사용자 이메일',
              ),
            ),
            TextField(
              controller: viewModel.passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                try {
                  viewModel.signUp(name: '이정민', id: '123456').then((_) {
                    print('회원가입 성공');
                    context.push('/');
                  });
                } catch (error) {
                  print('오류로 인한 회원가입 실패: $error');
                  return;
                }
              },
              child: Text('가입'),
            ),
          ],
        ),
      ),
    );
  }
}
