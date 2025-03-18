import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'calendar_screen.dart'; // ✅ 캘린더 화면 추가
import 'group_list_screen.dart'; // ✅ 그룹 리스트 화면 추가
import 'my_page_screen.dart'; // ✅ 마이페이지 화면 추가
import 'meeting_list_screen.dart';
import 'group_info_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // ✅ 현재 선택된 탭 인덱스
  final List<Widget> _screens = [
    CalendarScreen(),
    MeetingListScreen(),
    GroupInfoScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // ✅ 선택된 화면을 보여줌
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}