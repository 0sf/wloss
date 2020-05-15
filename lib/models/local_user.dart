import 'package:hive/hive.dart';

part 'local_user.g.dart';

@HiveType(typeId: 0)
class LocalUser {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final String gender;

  @HiveField(3)
  double activityFactor;
  
  @HiveField(4)
  double height;

  @HiveField(5)
  double weight;

  @HiveField(6)
  String name;
  
  LocalUser({
    this.id,
    this.age,
    this.gender,
    this.name,
    this.activityFactor = 0,
    this.height = 0,
    this.weight = 0,
  });
}