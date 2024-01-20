import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_example/constant/app_color.dart';
import 'package:to_do_example/presentation/controllers/todo_controller.dart';
import 'package:to_do_example/presentation/widgets/todo_row.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();

    return Scaffold(
      appBar: _todoAppBar(controller),
      body: Obx(() => _buildTodoList(controller)),
    );
  }

  AppBar _todoAppBar(TodoController controller) => AppBar(
        title: const Text(
          'To Do',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 28,
            ),
            onPressed: () {
              controller.initiateNewTodo();
            },
          ),
        ],
      );

  Widget _buildTodoList(TodoController controller) {
    final isTodoListEmpty = controller.pendingTodos.isEmpty;
    final isAddingNewTodo = controller.isAddingNewTodo.value;
    final todoCount = controller.pendingTodos.length;

    final editingIndex = controller.editingTodoIndex.value;

    if (isTodoListEmpty && !isAddingNewTodo) {
      return const Center(child: Text('할 일을 추가해주세요!'));
    }
    return ReorderableListView.builder(
      itemCount: todoCount + (isAddingNewTodo ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == todoCount && isAddingNewTodo) {
          return _textField(
            controller: controller,
            key: Key(controller.newTodoKey.value),
          );
        } else if (index == editingIndex) {
          return _textField(
            controller: controller,
            key: Key('order_${controller.pendingTodos[index].id}'),
          );
        }
        final todo = controller.pendingTodos[index];
        return TodoRow(
          key: Key('order_${todo.id}'),
          todo: todo,
          onButtonTap: () => controller.toggleTodoIsDone(todo),
          onEdit: () => controller.startTodoEditing(index),
          onDelete: () => controller.deleteTodo(todo),
        );
      },
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        controller.reorderTodoList(oldIndex, newIndex);
      },
      shrinkWrap: true,
    );
  }

  Widget _textField({required Key key, required TodoController controller}) =>
      Padding(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.circle_outlined,
              color: AppColor.deactivated,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller.textEditingController,
                focusNode: controller.focusNode,
                onSubmitted: (value) {
                  controller.handleTodoSubmit();
                },
                decoration: const InputDecoration(isDense: true),
              ),
            ),
          ],
        ),
      );
}
