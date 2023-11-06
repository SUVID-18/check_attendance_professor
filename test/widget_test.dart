import 'package:check_attendance_professor/firebase_options.dart';
import 'package:check_attendance_professor/main.dart';
import 'package:check_attendance_professor/view/login.dart';
import 'package:check_attendance_professor/view/settings_page.dart';
import 'package:check_attendance_professor/view/subject_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('앱이 정상적으로 실행 되는지 확인', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await tester.pumpWidget(App());
    });
  });

  group('기본적인 화면 구성 점검', () {
    testWidgets('로그인 페이지 확인', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));
      expect(find.text('로그인'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
    });
    testWidgets('과목 설정 페이지 확인', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: SubjectSettingsPage(),
      ));
      await widgetTester.tap(find.byIcon(Icons.delete));
      await widgetTester.pumpAndSettle();
      expect(find.text('삭제하시겠습니까?'), findsOneWidget);
    });
    testWidgets('설정 페이지 확인(계정 정보 확인)', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: SettingsPage(),
      ));
      expect(find.text('계정 정보 확인'), findsOneWidget);
      await widgetTester.tap(find.text('계정 정보 확인'));
      await widgetTester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
    });
    testWidgets('설정 페이지 확인(로그아웃)', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: SettingsPage(),
      ));
      expect(find.text('로그아웃'), findsOneWidget);
      await widgetTester.tap(find.text('로그아웃'));
      await widgetTester.pumpAndSettle();
      expect(find.text('로그아웃 하시겠습니까?'), findsOneWidget);
    });
  });
}
