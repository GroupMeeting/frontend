import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now(); // 현재 포커스된 날짜
  DateTime? _selectedDay; // 선택된 날짜
  Map<DateTime, List<String>> _events = {}; // 날짜별 스케줄 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캘린더'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // 캘린더 위젯
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              titleTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          // 선택된 날짜 표시
          if (_selectedDay != null)
            Text(
              '선택된 날짜: ${_selectedDay!.year}-${_selectedDay!.month}-${_selectedDay!.day}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 20),
          // 일정 리스트
          Expanded(
            child: _selectedDay == null || _events[_selectedDay] == null
                ? Center(
                    child: Text(
                      '선택된 날짜에 일정이 없습니다.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _events[_selectedDay]!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_events[_selectedDay]![index]),
                        leading: Icon(Icons.event),
                      );
                    },
                  ),
          ),
        ],
      ),
      // 일정 추가 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          // 스케줄 추가
          _addEvent(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // 일정 추가 다이얼로그
  void _addEvent(BuildContext context) {
    TextEditingController _eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('일정 추가'),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(hintText: '일정을 입력하세요'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              if (_eventController.text.isNotEmpty) {
                setState(() {
                  if (_events[_selectedDay] == null) {
                    _events[_selectedDay!] = [];
                  }
                  _events[_selectedDay!]!.add(_eventController.text);
                });
                Navigator.pop(context);
              }
            },
            child: Text('추가'),
          ),
        ],
      ),
    );
  }
}