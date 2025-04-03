import 'package:hive/hive.dart';

part 'userModel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String name;

  @HiveField(2)
  String password;

  @HiveField(3)
  String birthDate;

  @HiveField(4)
  String phone;

  @HiveField(5)
  String address;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.birthDate,
    required this.phone,
    required this.address,
  });
}