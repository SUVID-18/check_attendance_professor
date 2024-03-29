import 'package:check_attendance_professor/model/attendance_information.dart';
import 'package:check_attendance_professor/view/styles.dart';
import 'package:check_attendance_professor/view_model/attendance_management.dart';
import 'package:flutter/material.dart';

/// 학생들 출결 상태 확인 및 관리 페이지(과목 목록에서 과목 선택 시 화면)

class AttendanceManagementPage extends StatefulWidget {
  final String subjectID;

  const AttendanceManagementPage({required this.subjectID, Key? key})
      : super(key: key);

  @override
  State<AttendanceManagementPage> createState() =>
      _AttendanceManagementPageState();
}

class _AttendanceManagementPageState extends State<AttendanceManagementPage> {
  var viewModel = AttendanceManagementViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('학생 출결관리')),

      //ListView를 사용해 리스트를 동적으로 나타내도록 함
      body: StreamBuilder<List<AttendanceInformation>?>(
          stream: viewModel.loadAttendanceDB(widget.subjectID),
          builder: (BuildContext context,
              AsyncSnapshot<List<AttendanceInformation>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else if ((snapshot.data == null) || (snapshot.data!.isEmpty)) {
              return const Center(
                  child: ResultNotFound(
                text: '확인 가능한 출결 기록이 존재하지 않습니다.',
              ));
            } else {
              var attendanceList = snapshot.data!;
              return ListView.builder(
                ///리스트의 길이 만큼 카운트
                itemCount: attendanceList.length,

                ///위젯을 인덱스 만큼 만들도록 함
                itemBuilder: (context, index) {
                  ///학생별 출결 정보를 변경 할 수 있도록 하는 gesturedetector
                  ///alertDialog를 통해 각 상태별 버튼을 누르면 출결 정보가 변경 된다
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        shape: const Border(),
                        title: Column(
                          children: [
                            Text(
                              attendanceList[index].subjectName,
                              style: const TextStyle(
                                  fontSize: 23.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              attendanceList[index].studentName,
                              style: const TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                            Text(
                              attendanceList[index].studentID,
                              style: const TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                            Text(
                              attendanceList[index].result.toString(),
                              style: const TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                            Text(
                              attendanceList[index].dateTime.toString(),
                              style: const TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        children: [
                          const Text('출결 결과 변경하기',
                              style: TextStyle(
                                  fontSize: 23.0, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                  onPressed: () async {
                                    await viewModel.editAttendanceInformation(
                                        attendanceList[index],
                                        AttendanceResult.normal);
                                    setState(() {});
                                  },
                                  child: const Text('출석',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold))),
                              TextButton(
                                  onPressed: () async {
                                    await viewModel.editAttendanceInformation(
                                        attendanceList[index],
                                        AttendanceResult.tardy);
                                    setState(() {});
                                  },
                                  child: const Text('지각',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold))),
                              TextButton(
                                  onPressed: () async {
                                    await viewModel.editAttendanceInformation(
                                        attendanceList[index],
                                        AttendanceResult.absent);
                                    setState(() {});
                                  },
                                  child: const Text('결석',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold))),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
