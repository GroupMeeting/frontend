// selectedContact.dart
import 'package:hive/hive.dart';

part 'selectedContact.g.dart';

@HiveType(typeId: 34) // 다른 모델과 겹치지 않는 typeId 사용
class SelectedContact {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  SelectedContact({
    required this.name,
    required this.phone,
  });
}