import 'package:to_do_example/data/datasources/local_todo_data_source.dart';
import 'package:to_do_example/data/repositories/todo_repository.dart';
import 'package:to_do_example/domain/todo/todo.dart';

class LocalTodoRepository implements TodoRepository {
  final LocalTodoDataSource _localTodoDataSource;

  LocalTodoRepository(this._localTodoDataSource);

  @override
  Future<List<Todo>> getTodoList() async {
    return await _localTodoDataSource.getTodoList();
  }

  @override
  Future<void> createTodo(Todo todo) {
    return _localTodoDataSource.createTodo(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return _localTodoDataSource.deleteTodo(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return _localTodoDataSource.updateTodo(todo);
  }

  @override
  Future<void> reorderTodo(int oldIndex, int newIndex) {
    return _localTodoDataSource.updateTodoOrder(oldIndex, newIndex);
  }
}
