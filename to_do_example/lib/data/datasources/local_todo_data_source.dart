import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_example/domain/todo/todo.dart';

class LocalTodoDataSource {
  final String _boxName = 'todo';
  Future<Box<Todo>> get _todoBox async => await Hive.openBox<Todo>(_boxName);

  Future<List<Todo>> getTodoList() async {
    final box = await _todoBox;
    return box.values.toList();
  }

  Future<void> createTodo(Todo todo) async {
    final box = await _todoBox;
    await box.put(todo.id, todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    final box = await _todoBox;
    await box.delete(todo.id);
  }

  Future<void> updateTodo(Todo todo) async {
    final box = await _todoBox;
    await box.put(todo.id, todo);
  }

  Future<void> updateTodoOrder(int oldIndex, int newIndex) async {
    final box = await _todoBox;
    final todoList = box.values.toList();
    final pendingTodos = todoList.where((todo) => !todo.isDone).toList();

    final oldItem = pendingTodos.removeAt(oldIndex);
    pendingTodos.insert(newIndex, oldItem);

    int pendingIndex = 0;
    for (int i = 0; i < todoList.length; i++) {
      if (!todoList[i].isDone) {
        todoList[i] = pendingTodos[pendingIndex++];
      }
    }

    for (var i = 0; i < todoList.length; i++) {
      await box.putAt(i, todoList[i]);
    }
  }
}
