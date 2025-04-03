// 파일 위치: lib/screens/widgets/contact_picker_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPickerDialog extends StatefulWidget {
  final List<Contact> contacts;
  final Function(List<String> selectedNames, List<String> selectedNumbers) onContactsSelected;

  const ContactPickerDialog({
    Key? key,
    required this.contacts,
    required this.onContactsSelected,
  }) : super(key: key);

  @override
  _ContactPickerDialogState createState() => _ContactPickerDialogState();
}

class _ContactPickerDialogState extends State<ContactPickerDialog> {
  List<Contact> _filteredContacts = [];
  final Set<Contact> _selectedContacts = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredContacts = widget.contacts;
    _searchController.addListener(_filterContacts);
  }

  void _filterContacts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = widget.contacts.where((contact) {
        return contact.displayName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterContacts);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('전화번호 선택'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: '이름으로 검색',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredContacts.length,
                itemBuilder: (context, index) {
                  Contact contact = _filteredContacts[index];
                  String phoneNumber = contact.phones.isNotEmpty
                      ? contact.phones.first.number
                      : '';
                  return CheckboxListTile(
                    title: Text(contact.displayName),
                    subtitle: Text(phoneNumber),
                    value: _selectedContacts.contains(contact),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _selectedContacts.add(contact);
                        } else {
                          _selectedContacts.remove(contact);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            // 선택된 연락처의 첫번째 전화번호만 예시로 추출합니다.
            // _selectedContacts는 Contact 객체들의 Set이라고 가정합니다.
            List<String> selectedNames = _selectedContacts.map((contact) {
              return contact.displayName.isNotEmpty ? contact.displayName : '이름 없음';
            }).toList();

            List<String> selectedNumbers = _selectedContacts.map((contact) {
              return contact.phones.isNotEmpty ? contact.phones.first.number : '';
            }).toList();
            widget.onContactsSelected(selectedNames, selectedNumbers);
            print("문자열과 함께 context 값: ${selectedNames.toString()}");
            Navigator.pop(context);
          },
          child: const Text('번호 추가'),
        ),
      ],
    );
  }
}