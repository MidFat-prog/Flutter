import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  int get completedCount => _tasks.where((t) => t.isCompleted).length;

  void addTask(String title, {String description = ''}) {
    if (title.trim().isEmpty) return;
    _tasks.add(
      Task(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title.trim(),
        description: description.trim(),
      ),
    );
    notifyListeners();
  }

  void editTask(String id, {required String title, String description = ''}) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.title = title.trim();
    task.description = description.trim();
    notifyListeners();
  }

  void toggleCompleted(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}