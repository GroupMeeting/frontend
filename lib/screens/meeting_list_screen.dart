import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:frontend/models/dongari_model.dart'; // DongariModel이 정의된 파일

class MeetingListScreen extends StatefulWidget {
  const MeetingListScreen({Key? key}) : super(key: key);

  @override
  _MeetingListScreenState createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends State<MeetingListScreen> {
  late Box<DongariModel> _dongariBox;
  List<DongariModel> _dongariData = [];

  @override
  void initState() {
    super.initState();
    _loadDongariData();
  }

  Future<void> _loadDongariData() async {
    // 이미 Hive.initFlutter()와 어댑터 등록이 main()에서 완료되었다고 가정합니다.
    _dongariBox = Hive.box<DongariModel>('dongari');
    setState(() {
      _dongariData = _dongariBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동아리'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _dongariData.isEmpty
          ? const Center(
              child: Text('가입된 동아리가 없습니다.'),
            )
          : ListView.builder(
              itemCount: _dongariData.length,
              itemBuilder: (context, index) {
                final dongari = _dongariData[index];

                // 동아리 이미지 표시: 로컬 파일 경로가 있다면 File() 사용, 없으면 기본 이미지 표시
                final imageWidget = (dongari.imagePath != null &&
                        dongari.imagePath!.isNotEmpty)
                    ? Image.file(
                        File(dongari.imagePath!),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                      'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    );

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: imageWidget,
                    title: Text(dongari.name),
                    subtitle: Text('회비날짜: ${dongari.feeDate}\n활동지역: ${dongari.region}'),
                    onTap: () {
                      // 동아리 카드 클릭 시 모임방 화면으로 이동 (필요 시 해당 화면 구현)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubMeetingRoomScreen(clubName: dongari.name),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 동아리 생성 페이지로 이동
          Navigator.pushNamed(context, '/createDongari');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

// 예시로 동아리 모임방 화면
class ClubMeetingRoomScreen extends StatelessWidget {
  final String clubName;
  const ClubMeetingRoomScreen({Key? key, required this.clubName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$clubName 모임방'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text('$clubName 방에 오신 것을 환영합니다.'),
      ),
    );
  }
}