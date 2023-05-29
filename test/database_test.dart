import 'package:check_attendance_professor/firebase_options.dart';
import 'package:check_attendance_professor/model/attendance_information.dart';
import 'package:check_attendance_professor/viewmodel/dbconnector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';


void main(){
  test('db 연동 테스트', () async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    DBConnectorViewModel viewmodel = DBConnectorViewModel();
    List<AttendanceInformation> list = await viewmodel.loadAttendanceDB();

    print(list);
  });
}