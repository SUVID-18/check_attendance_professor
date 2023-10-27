import 'package:check_attendance_professor/view_model/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 앱 내 환경설정에 해당되는 페이지 입니다.
///
/// 이곳에서 계정 정보 확인 및 로그아웃이 가능합니다.
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var viewModel = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings', style: TextStyle(fontSize: 22)),
        ),
        body: SafeArea(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
              const SizedBox(height: 20),

              ///상단 부제목 부분
              const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text('Account',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),

              ///여백용 SizedBox
              const SizedBox(height: 10),
              //계정정보란
              //터치시 AlertDialog 이용하여 계정정보를 보여줌
              //그냥 쓰니 text overflow가 나서 sizedbox로 감싸고 shrinkwarp사용
              ListTile(
                title: Text('계정 정보 확인',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600])),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text('계정정보'),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Text('이름: ${viewModel.professorInfo.name}'),
                                    Text('교번: ${viewModel.professorInfo.id}')
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('확인'))
                              ]));
                },
              ),

              ///로그아웃 란
              //터치시 AlertDialog이용 로그아웃 여부 질문
              //확인 버튼 터치시 로그인 화면 이동, 취소버튼시 이전화면으로 push처리
              //확인 버튼은 비교적 짙은색의 elevetedbutton, 취소버튼은 textbutton
              ListTile(
                title: Text('로그아웃',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600])),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text('로그아웃'),
                              content: const Text('로그아웃 하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('취소')),
                                ElevatedButton(
                                    onPressed: () {
                                      viewModel.signOut().then((_) {
                                        if (context.mounted) {
                                          context.go('/');
                                        }
                                      });
                                    },
                                    child: const Text('확인'))
                              ]));
                },
              ),
            ])));
  }
}
