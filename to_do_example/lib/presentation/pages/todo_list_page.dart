import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_example/common_widget/custom_bottom_navigation_bar.dart';
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
      bottomNavigationBar: const CustomBottomNavigationBar(),
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
    final isTodoListEmpty = controller.todoList.isEmpty;
    final isAddingNewTodo = controller.isAddingNewTodo.value;
    final todoCount = controller.todoList.length;

    final editingIndex = controller.editingTodoIndex.value;

    if (isTodoListEmpty && !isAddingNewTodo) {
      return const Center(child: Text('할 일을 추가해주세요!'));
    }
    return ListView.builder(
      itemCount: todoCount + (isAddingNewTodo ? 1 : 0),
      itemBuilder: (context, index) {
        final todo = controller.todoList[index];
        if (index == todoCount && isAddingNewTodo) {
          return _textField(controller);
        } else if (index == editingIndex) {
          return _textField(controller);
        }
        return TodoRow(
            todo: todo,
            onButtonTap: () => controller.toggleTodoIsDone(todo),
            onEdit: () => controller.startTodoEditing(index),
            onDelete: () => controller.deleteTodo(todo));
      },
      shrinkWrap: true,
    );
  }

  Widget _textField(TodoController controller) => Padding(
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
