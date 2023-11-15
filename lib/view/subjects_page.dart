import 'package:check_attendance_professor/model/subject.dart';
import 'package:check_attendance_professor/view/styles.dart';
import 'package:check_attendance_professor/view_model/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 본인의 과목 목록이 표시되는 페이지(로그인 이후 실제 메인 페이지로 될 것으로 보임)

class SubjectPage extends StatelessWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = SubjectPageViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('과목 목록'),
        actions: [
          IconButton(
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings))
        ],
      ),

      ///카드 사용해서 클릭시 상세정보로 넘어감.
      body: Center(
        child: FutureBuilder<List<Subject>?>(
            future: viewModel.loadSubjectDB(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.data == null) {
                return const ResultNotFound(
                  text: '등록된 과목이 존재하지 않습니다.',
                );
              } else {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 400,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () => context.push('/${snapshot.data![index].subjectID}'),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data![index].subjectName,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_city),
                                        Text(snapshot.data![index].major)
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.settings),
                                    title: const Text('과목 설정'),
                                    onTap: () => context.push(
                                        '/${snapshot.data![index].subjectID}/settings'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350.0),
                );
              }
            }),
      ),
    );
  }
}