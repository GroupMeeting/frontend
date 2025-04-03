import 'package:flutter/material.dart';

/// 재사용 가능한 커스텀 모달 위젯입니다.
/// 어디서든 제목, 본문, 액션 버튼들을 전달하여 모달을 띄울 수 있습니다.
class CustomModal extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const CustomModal({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Dialog의 크기를 내용에 맞게 조절
          mainAxisSize: MainAxisSize.min,
          children: [
            // 제목
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            // 본문 내용
            content,
            const SizedBox(height: 24),
            // 액션 버튼들 (예: 취소, 확인)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}