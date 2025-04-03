// dongari_model.dart
import 'package:hive/hive.dart';
import 'selectedContact.dart';

part 'dongari_model.g.dart';

@HiveType(typeId: 1)
class DongariModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String feeDate;

  @HiveField(2)
  final String region;

  // 연락처 리스트를 List<SelectedContact>로 변경
  @HiveField(3)
  final List<SelectedContact> contacts;

  @HiveField(4)
  final String? imagePath;

  DongariModel({
    required this.name,
    required this.feeDate,
    required this.region,
    required this.contacts,
    this.imagePath,
  });
}