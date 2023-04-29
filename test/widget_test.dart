import 'package:check_attendance_professor/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('앱이 정상적으로 실행 되는지 확인', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(App());
    });
  });
}
