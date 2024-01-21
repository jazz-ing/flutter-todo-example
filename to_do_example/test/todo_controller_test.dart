import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_example/data/repositories/mock_local_todo_repository.dart';
import 'package:to_do_example/presentation/controllers/todo_controller.dart';

void main() {
  late TodoController controller;

  setUp(() {
    controller = TodoController(todoRepository: MockLocalTodoRepository());
  });

  test('할 일 목록 가져오기', () async {
    await controller.fetchTodoList();
    expect(controller.todoList.isNotEmpty, true);
  });

  test('새로운 할 일 추가하기', () async {
    await controller.fetchTodoList();
    var initialLength = controller.todoList.length;
    controller.createTodo(text: '새로운 할 일');
    expect(controller.todoList.length, initialLength + 1);
  });

  test('할 일 삭제하기', () async {
    await controller.fetchTodoList();
    var initialLength = controller.todoList.length;
    var todoToDelete = controller.todoList.first;
    controller.deleteTodo(todoToDelete);
    expect(controller.todoList.length, initialLength - 1);
  });

  test('할 일 수정하기', () async {
    await controller.fetchTodoList();
    var todoToEdit = controller.pendingTodos.first;
    var initialTitle = todoToEdit.title;
    controller.editingTodoIndex.value = 0;
    controller.editTodo(text: '수정된 할 일');
    expect(controller.pendingTodos.first.title, isNot(initialTitle));
  });
}
