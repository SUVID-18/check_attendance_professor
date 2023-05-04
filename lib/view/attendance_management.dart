import 'package:flutter/material.dart';

/// 학생들 출결 상태 확인 및 관리 페이지(과목 목록에서 과목 선택 시 화면)

class AttendanceManagementPage extends StatefulWidget {
  const AttendanceManagementPage({Key? key}) : super(key: key);

  @override
  State<AttendanceManagementPage> createState() =>
      _AttendanceManagementPageState();
}

class _AttendanceManagementPageState extends State<AttendanceManagementPage> {
  ///강의실 리스트
  List<Map<String, dynamic>> _dataList = [
    {'name': '이정민', 'id': '123456789', 'attendance': '출석'},
    {'name': '윤솔빈', 'id': '987654321', 'attendance': '출석'},
    {'name': '한동민', 'id': '192837465', 'attendance': '출석'},
  ];

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
          ///태그한 내용을 탭하여 업로드 할 수 있도록 하는 gesturedetector
          ///alertDialog를 통해 강의실 번호를 입력 받아 확인시 업로드가 된다
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(title: Text("학생 정보"), actions: <Widget>[
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
            //호수와 고유번호가 보임
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
