import 'dart:async';

import 'package:check_attendance_professor/firebase_options.dart';
import 'package:check_attendance_professor/view/attendance_management.dart';
import 'package:check_attendance_professor/view/login.dart';
import 'package:check_attendance_professor/view/main_page.dart';
import 'package:check_attendance_professor/view/settings_page.dart';
import 'package:check_attendance_professor/view/subject_settings.dart';
import 'package:check_attendance_professor/view/subjects_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 릴리즈 모드 여부에 따라 리다이렉트 여부를 지정하는 함수
///
/// 릴리즈 모드인 경우 로그인이 되어있지 않은 경우 로그인을 진행하도록 강제한다.
/// 릴리즈 모드가 아닌 경우 원할한 개발을 위해 로그인 과정을 건너뛴다.
FutureOr<String?> loginRedirect(context, state) async {
  if (!kReleaseMode) {
    return null;
  }
  if (FirebaseAuth.instance.currentUser == null) {
    return '/login';
  } else {
    return null;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

/// 앱 이름에 해당되는 상수
const String appName = '전출 시스템(강의자용)';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final GoRouter _routes = GoRouter(routes: [
    // 앱 실행 시 가장 먼저 출력되는 로그인 페이지
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
        redirect: loginRedirect,
        path: '/',
        builder: (context, state) => const MainPage(
              appName: appName,
            ),
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
              path: 'subjects',
              builder: (context, state) => const SubjectPage(),
              routes: [
                GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      String? subjectID = state.pathParameters['id'];
                      return AttendanceManagementPage(
                        subjectID: subjectID!,
                      );
                    },
                    routes: [
                      // 위에 있는거랑 다름. 얘는 /subjects/<과목ID>/settings임.
                      GoRoute(
                          path: 'settings',
                          builder: (context, state) {
                            String? subjectID = state.pathParameters['id'];

                            return SubjectSettingsPage(subjectID: subjectID!);
                          },
                      ),
                    ])
              ]),
        ]),
  ]);


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      routerConfig: _routes,
      theme: ThemeData(
        // Material3 테마를 사용할지에 대한 여부
          useMaterial3: true),
    );
  }
}
