import 'package:flutter/material.dart';

/// 본인의 과목 목록이 표시되는 페이지(로그인 이후 실제 메인 페이지로 될 것으로 보임)

class SubjectPage extends StatelessWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('과목 목록'),
      ),

      ///카드 사용해서 클릭시 상세정보로 넘어감.
      ///총 4개


      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              ///한번 클릭시
              onTap: () {
                Navigator.push(
                  context,
                  ///다음 화면으로 이동
                  MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(
                          appBar: AppBar(
                            title: const Text('상세 정보'),
                      ),
                          body: const Center(
                        child: Text('1학년 전공필수'),
                      ),
                        ),
                  ),
                );
              },

              ///카드안에 교과목 + 간단한 사진 등록했음.
              /// 이미지는 어차피 자기 과목들만 뜨니깐 교실 앞 호수 같은거 이용해도 될듯.
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('디지털논리회로'),
                    const SizedBox(height: 20),
                    Image.asset('asset/image/JST.jpg'),
                  ],
                ),
              ),
              ),
            ),



          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(
                          appBar: AppBar(
                            title: const Text('상세 정보'),
                      ),
                          body: const Center(
                        child: Text('2학년 전공필수'),
                      ),
                        ),
                  ),
                );
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('컴퓨터 구조'),
                    const SizedBox(height: 20),
                    Image.asset('asset/image/JST.jpg'),
                  ],
                ),
              ),
            ),
          ),

          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(
                          appBar: AppBar(
                            title: const Text('상세 정보'),
                      ),
                          body: const Center(
                        child: Text('2학년 전공선택'),
                      ),
                        ),
                  ),
                );
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('디지털회로 및 실습'),
                    const SizedBox(height: 20),
                    Image.asset('asset/image/JST.jpg'),
                  ],
                ),
              ),
            ),
          ),


          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(
                          appBar: AppBar(
                            title: const Text('상세 정보'),
                      ),
                          body: const Center(
                        child: Text('4학년 전공필수'),
                      ),
                        ),
                  ),
                );
              },
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('졸업프로젝트'),
                    const SizedBox(height: 20),
                    Image.asset('asset/image/JST.jpg'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}