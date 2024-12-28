import 'package:hive_flutter/hive_flutter.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String date;
  @HiveField(3)
  int color;

  ReminderModel({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });
}