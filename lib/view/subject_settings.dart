import 'package:check_attendance_professor/model/lecture.dart';
import 'package:check_attendance_professor/view_model/subject_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 과목 관련 설정(유효 출결시간은 언제로 할지.., 과목을 버릴지..) 페이지

class SubjectSettingsPage extends StatefulWidget {
  final String subjectID;
  const SubjectSettingsPage({Key? key, required this.subjectID}) : super(key: key);

  @override
  State<SubjectSettingsPage> createState() => _SubjectSettingsPageState();
}

class _SubjectSettingsPageState extends State<SubjectSettingsPage> {
  ///유효시간 설정 변수
  int validTime = 0;
  late var viewModel = SubjectSettingsViewModel(subjectID: widget.subjectID);

  @override
  Widget build(BuildContext context) {
    // TODO(front): 과목 관련 설정 화면 구성하기
    return Scaffold(
      appBar: AppBar(
        title: const Text("과목 설정"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 10),

            ///상단 부제목 부분
            const Row(
              children: [
                Icon(
                  Icons.watch,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('출결 관리',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ],
            ),

            ///여백용 SizedBox
            const SizedBox(height: 10),

            ///유효 출결 시간 설정
            //textbutton으로 시간 설정 가능하게 표현
            //validTime 변수를 통해 setstate로 유효시간 설정 시 화면에 표시 되도록 구현
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: const Text('출결 시간 설정'),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () async{
                                        await viewModel.updateValidTime(5);
                                        Navigator.pop(context);
                                      },
                                    child: const Text('5분')),
                                TextButton(
                                    onPressed: () async{
                                        await viewModel.updateValidTime(10);
                                        Navigator.pop(context);
                                    },
                                    child: const Text('10분')),
                                TextButton(
                                    onPressed: () async{
                                        await viewModel.updateValidTime(15);
                                        Navigator.pop(context);
                                    },
                                    child: const Text('15분')),
                                TextButton(
                                    onPressed: () async{
                                        await viewModel.updateValidTime(30);
                                        Navigator.pop(context);
                                    },
                                    child: const Text('30분')),
                              ],
                            ),
                          ),
                      )
                  );
                },

                //안쪽 여백을 위해 Container가 아닌 padding을 이용
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                    child: Row(
                      //여백을 주기위한 spaceBetween
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('유효 출결 시간 설정',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600])),

                        ///설정 시간을 나타내주는 텍스트
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: viewModel.getValidTime(),
                            builder: (context, snapshot) {
                              if ((snapshot.connectionState ==
                                      ConnectionState.waiting) ||
                                  (snapshot.data == null)) {
                                return Container();
                              }
                              return Text(
                                '${Lecture.fromJson(snapshot.data!.docs.first.data()).validTime}분',
                                style: const TextStyle(fontSize: 15),
                              );
                            }),
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey)
                      ],
                    ))),
            const SizedBox(height: 20),

            ///과목 관리 탭
            ///상단 테마
            const Row(
              children: [
                Icon(
                  Icons.book,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('과목 관리',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ],
            ),

            ///과목 삭제
            //AlrertDialog를 띄워 과목 삭제 여부를 물어보게끔 구현함
            ListTile(
              title: Text('과목 삭제',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600])),
              trailing: const Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                            title: const Text('과목 삭제'),
                        content: const SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [Text('삭제하시겠습니까?')],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('취소')),
                              TextButton(
                                  onPressed: () {
                                    viewModel.deleteSubject();
                                    context.go('/subjects');
                                  },
                                  child: const Text('확인'))
                            ]));
              },
            )
          ],
        ),
      ),
    );
  }
}
