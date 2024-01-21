import 'package:to_do_example/data/repositories/todo_repository.dart';
import 'package:to_do_example/domain/todo/todo.dart';

class MockLocalTodoRepository implements TodoRepository {
  var todoListData = [
    Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Todo 1',
      isDone: false,
      orderIndex: 0,
    ),
    Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Todo 2',
      isDone: false,
      orderIndex: 1,
    ),
    Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Todo 3',
      isDone: false,
      orderIndex: 2,
    ),
    Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Todo 4',
      isDone: false,
      orderIndex: 3,
    ),
    Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Todo 5',
      isDone: false,
      orderIndex: 4,
    ),
  ];

  @override
  Future<List<Todo>> getTodoList() async {
    return todoListData;
  }

  @override
  Future<void> createTodo(Todo todo) async {
    todoListData.add(todo);
    return;
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    todoListData.remove(todo);
    return;
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final oldTodo = todoListData.firstWhere((t) => t.id == todo.id);
    final index = todoListData.indexOf(oldTodo);
    todoListData[index] = todo;
    return;
  }

  @override
  Future<void> reorderTodo(int oldIndex, int newIndex) async {
    final oldItem = todoListData.removeAt(oldIndex);
    todoListData.insert(newIndex, oldItem);
    return;
  }
}
