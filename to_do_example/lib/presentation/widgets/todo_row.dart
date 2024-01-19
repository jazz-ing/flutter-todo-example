import 'package:flutter/material.dart';
import 'package:to_do_example/constant/app_color.dart';
import 'package:to_do_example/domain/todo/todo.dart';

class TodoRow extends StatelessWidget {
  final Todo todo;
  final VoidCallback onButtonTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoRow({
    super.key,
    required this.todo,
    required this.onButtonTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 24,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: onButtonTap,
              child: todo.isDone
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColor.theme,
                    )
                  : Icon(Icons.circle_outlined, color: AppColor.deactivated),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: todo.isDone ? null : onEdit,
                child: Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: todo.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: todo.isDone ? AppColor.deactivated : Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
