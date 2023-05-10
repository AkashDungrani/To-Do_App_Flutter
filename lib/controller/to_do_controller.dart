import 'package:get/get.dart';
import '../dbhelper/db_helper.dart';
import '../models/to_do_models.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    print(task!.date);
    return await DBHelper.dbHelper.insert(task: task);
  }
}
