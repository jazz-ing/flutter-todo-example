import 'package:to_do_example/domain/todo/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodoList();
  Future<void> createTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> reorderTodo(int oldIndex, int newIndex);
}
