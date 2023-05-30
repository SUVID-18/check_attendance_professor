import 'package:check_attendance_professor/view_model/login.dart';
import 'package:flutter/material.dart';

/// 로그인 시 나타나는 페이지 입니다.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 아이디와 비밀번호 변수
  /// TextEditingController로 구현해서 인스턴스의 핸들링 함수를 리스너로 등록해줘야함
  /// _usernameController는 아이디
  /// _passwardController는 비밀번호
  final viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        /// 앱 크기 조정을 수평 대칭적으로 함
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          ///상단 출석체크 위젯
          ///asset/image/swu_horizontalLogo.png 이미지 추가해놓음
          SizedBox(height: 80.0),
          Column(
            children: <Widget>[
              Image.asset('asset/image/swu_horizontalLogo.png'),
              SizedBox(height: 1.0),
              Text(
                '수원대 전자출결 앱',
                style: TextStyle(fontSize: 30),
              ),
            ],
              ),

              ///아이디 및 비밀번호 입력란
              ///_usernameController 변수 사용
              SizedBox(
                height: 60.0,
              ),
              TextField(
                controller: viewModel.userEmailController,
            decoration: InputDecoration(filled: true, labelText: 'Email'),
          ),

              ///비밀번호 입력란
              ///obscureText 사용 비밀번호 입력시 숨김
              SizedBox(height: 12.0),
              TextField(
                controller: viewModel.passwordController,
            decoration: InputDecoration(filled: true, labelText: 'Passward'),
            obscureText: true,
          ),

              ///이벤트 버튼 구현 위젯
              ButtonBar(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => Dialog(
                        child: Row(
                          children: [
                            CircularProgressIndicator(),
                            Text(' 로그인 중...')
                          ],
                        ),
                      ),
                    );
                    viewModel.signIn().then((_) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('로그인이 완료되었습니다.')));
                    });
                  },
                  child: Text('로그인'))
            ],
              ),

              /// 하단 로고
              /// 이미지 에셋 해놓음
              Column(children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset('asset/image/swu_bluelogo.png')
          ]),
            ],
          ),
        ));
  }
}
