import 'package:check_attendance_professor/model/attendance_information.dart';
import 'package:check_attendance_professor/view_model/attendance_management.dart';
import 'package:flutter/material.dart';

/// 학생들 출결 상태 확인 및 관리 페이지(과목 목록에서 과목 선택 시 화면)

class AttendanceManagementPage extends StatefulWidget {
  const AttendanceManagementPage({Key? key}) : super(key: key);

  @override
  State<AttendanceManagementPage> createState() =>
      _AttendanceManagementPageState();
}

class _AttendanceManagementPageState extends State<AttendanceManagementPage> {
  var viewModel = DBConnectorViewModel();
  List<AttendanceInformation?> _dataList = [];

  ///학생 리스트
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar 부분
      appBar: AppBar(title: Text("업로드 페이지")),

      //ListView를 사용해 리스트를 동적으로 나타내도록 함
      body: ListView.builder(
        ///리스트의 길이 만큼 카운트
        itemCount: _dataList.length,

        ///위젯을 인덱스 만큼 만들도록 함
        itemBuilder: (context, index) {
          ///학생별 출결 정보를 변경 할 수 있도록 하는 gesturedetector
          ///alertDialog를 통해 각 상태별 버튼을 누르면 출결 정보가 변경 된다
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: Text("출결 수정", textAlign: TextAlign.center),
                          //출결 버튼
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _dataList[index]['attendance'] = '출석';
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('출석')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                _dataList[index]['attendance'] = '지각';
                              });
                              Navigator.pop(context);
                            },
                            child: Text('지각')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _dataList[index]['attendance'] = '결석';
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('결석')),
                          ]));
            },
            //이름과 학번, 출결 정보가 보인다
            //이정민식 디자인~
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      _dataList[index]['name'],
                      style: const TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _dataList[index]['id'],
                      style: const TextStyle(
                        fontSize: 23.0,
                      ),
                    ),
                    Text(
                      _dataList[index]['attendance'],
                      style: const TextStyle(
                        fontSize: 23.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}