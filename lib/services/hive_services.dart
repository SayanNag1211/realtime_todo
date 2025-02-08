import 'package:hive_flutter/adapters.dart';
import 'package:realtime_todo/model/employee_model.dart';

class HiveService {
  static const String _todoBoxName = 'detailsBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DetailsAdapter());
    await Hive.openBox<Details>(_todoBoxName);
  }

  static Box<Details> getTodoBox() {
    return Hive.box<Details>(_todoBoxName);
  }
}
