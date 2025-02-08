import 'package:hive/hive.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)
class Details extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final String fromDate;

  @HiveField(4)
  final String toDate;

  Details({
    required this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    required this.toDate,
  });
}
