import 'package:flutter/material.dart';

/// 데이터를 찾을 수 없을 때 사용되는 위젯
///
/// 어떤 동작을 수행하여 데이터를 가져올 때 데이터가 존재하지 않는 경우 사용이 가능한 위젯이다.
/// 기본적으로는 데이터가 존재하지 않는다는 글자가 뜨지만 [text]매개변수에 문장을 지정하면 해당 문장이
/// 대신 출력된다.
class ResultNotFound extends StatelessWidget {
  /// 데이터가 존재하지 않을 때 출력할 문장
  final String? text;

  const ResultNotFound({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.help),
        Text(
          text ?? '데이터가 존재하지 않습니다.',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
