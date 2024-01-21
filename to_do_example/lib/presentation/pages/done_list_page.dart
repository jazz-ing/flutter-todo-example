import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_example/presentation/controllers/todo_controller.dart';
import 'package:to_do_example/presentation/widgets/todo_row.dart';

class DoneListPage extends StatelessWidget {
  const DoneListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();

    return Scaffold(
      appBar: _doneAppBar,
      body: Obx(() => _buildDoneList(controller)),
    );
  }

  AppBar get _doneAppBar => AppBar(
        title: const Text(
          'Done',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      );

  Widget _buildDoneList(TodoController controller) {
    final isDoneListEmpty = controller.doneTodos.isEmpty;
    final doneCount = controller.doneTodos.length;

    if (isDoneListEmpty) {
      return const Center(child: Text('완료한 할 일이 없습니다'));
    }
    return ListView.builder(
      itemCount: doneCount,
      itemBuilder: (context, index) {
        final done = controller.doneTodos[index];
        return TodoRow(
          todo: done,
          onButtonTap: () => controller.toggleTodoIsDone(done),
          onEdit: () => controller.startTodoEditing(index),
          onDelete: () => controller.deleteTodo(done),
        );
      },
    );
  }
}
