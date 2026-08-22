import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/CustomButton.dart';

/// Tasks tab — a To-Do list demonstrating CRUD operations backed by
/// TaskProvider (ChangeNotifier) instead of local setState().
class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  void _showTaskForm(BuildContext context, {Task? existingTask}) {
    final titleController = TextEditingController(text: existingTask?.title ?? '');
    final descController =
    TextEditingController(text: existingTask?.description ?? '');
    final isEditing = existingTask != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Edit Task' : 'Add Task',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 18),
              CustomTextField(
                label: 'Title',
                hint: 'e.g. Buy groceries',
                controller: titleController,
                prefixIcon: Icons.task_alt_outlined,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                label: 'Description (optional)',
                hint: 'Add more detail',
                controller: descController,
                prefixIcon: Icons.notes_outlined,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: isEditing ? 'Save Changes' : 'Add Task',
                onPressed: () {
                  final title = titleController.text;
                  final desc = descController.text;
                  if (title.trim().isEmpty) return;

                  final provider = sheetContext.read<TaskProvider>();
                  if (isEditing) {
                    provider.editTask(existingTask.id,
                        title: title, description: desc);
                  } else {
                    provider.addTask(title, description: desc);
                  }
                  Navigator.pop(sheetContext);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Task?'),
        content: Text('"${task.title}" will be removed permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textGrey)),
          ),
          TextButton(
            onPressed: () {
              dialogContext.read<TaskProvider>().deleteTask(task.id);
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.watch rebuilds this widget whenever TaskProvider calls notifyListeners()
    final tasks = context.watch<TaskProvider>().tasks;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: tasks.isEmpty
          ? const _EmptyState()
          : ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return _TaskTile(
            task: task,
            onToggle: () =>
                context.read<TaskProvider>().toggleCompleted(task.id),
            onEdit: () => _showTaskForm(context, existingTask: task),
            onDelete: () => _confirmDelete(context, task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showTaskForm(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.tint,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.checklist_rtl, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap + to add your first task',
            style: TextStyle(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskTile({
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.tintBorder),
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: onToggle,
          child: Icon(
            task.isCompleted
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked,
            color: task.isCompleted ? AppColors.success : AppColors.primary,
            size: 28,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: task.isCompleted ? AppColors.textGrey : AppColors.textDark,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: task.description.isEmpty
            ? null
            : Text(
          task.description,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: AppColors.textGrey, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}