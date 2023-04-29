import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 홈 화면을 나타내는 페이지 입니다.
///
/// 홈 화면에서는 기본적으로 출결을 위한 태그 인식하기 버튼을 누를 수 있으며, 현재 출석을 하는 과목이 표시됩니다.
/// 또한 태그 접촉 완료 시의 화면도 표시됩니다.(이 부분은 백엔드 작업이 선행되어야 가능할 수도 있음)
class MainPage extends StatefulWidget {
  /// 앱의 이름에 해당되는 변수입니다.
  final String appName;

  const MainPage({required this.appName, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // 컨텐츠 가로 여백 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 컨텐츠를 수직 가운데 정렬
          crossAxisAlignment: CrossAxisAlignment.stretch, // 컨텐츠를 수평으로 꽉 채우기
          children: [
            Text(
              '페이지 이동 버튼 모음',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium, // headlineLarge -> headline4 로 변경
              textAlign: TextAlign.center, // 텍스트를 중앙 정렬
            ),

            const SizedBox(height: 32), // 버튼과 텍스트 사이 여백 추가
            MaterialButton(
              onPressed: () => context.push('/login'),
              minWidth: double.infinity,
              // 버튼의 최소 너비를 부모 컨테이너와 같게 설정
              height: 64,
              // 버튼의 고정된 높이 설정
              color: Colors.blue,
              // 버튼 색상 변경
              textColor: Colors.white,
              // 버튼 텍스트 색상 변경
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // 버튼의 모서리 둥글게 처리
              ),
              child: const Text('로그인/로그아웃 페이지로'),
            ),
            const SizedBox(height: 16), // 버튼과 버튼 사이 여백 추가

            MaterialButton(
              onPressed: () => context.push('/subjects'),
              minWidth: double.infinity,
              height: 64,
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('본인의 과목 목록이 표시되는 페이지로'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => context.push('/subjects/test'),
              minWidth: double.infinity,
              height: 64,
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('특정 과목의 출결 확인/관리 페이지로'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => context.push('/subjects/test/settings'),
              minWidth: double.infinity,
              height: 64,
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('특정 과목의 설정 페이지로'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => context.push('/settings'),
              minWidth: double.infinity,
              height: 64,
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('설정 페이지로'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
