import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_example/data/repositories/todo_repository.dart';
import 'package:to_do_example/domain/todo/todo.dart';

class TodoController extends GetxController {
  final TodoRepository todoRepository;
  final TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  TodoController({required this.todoRepository});

  @override
  void onInit() {
    super.onInit();
    fetchTodoList();
  }

  final todoList = <Todo>[].obs;
  final isAddingNewTodo = false.obs;
  final editingTodoIndex = Rx<int?>(null);

  Future<void> fetchTodoList() async {
    final todoList = await todoRepository.getTodoList();
    this.todoList.value = todoList;
  }

  void handleTodoSubmit() {
    final isEditing = editingTodoIndex.value != null;
    if (isEditing) {
      editTodo();
    } else {
      createTodo();
    }
    _resetTodoInput();
  }

  void createTodo() {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: textEditingController.text,
      isDone: false,
    );
    todoRepository.createTodo(todo);
  }

  void editTodo() {
    final todo = todoList[editingTodoIndex.value!]
        .copyWith(title: textEditingController.text);
    todoRepository.updateTodo(todo);
    fetchTodoList();
  }

  void deleteTodo(Todo todo) {
    todoRepository.deleteTodo(todo);
    fetchTodoList();
  }

  void initiateNewTodo() {
    editingTodoIndex.value = null;
    isAddingNewTodo.value = true;
    textEditingController.clear();
    focusNode.requestFocus();
  }

  void startTodoEditing(int index) {
    editingTodoIndex.value = index;
    textEditingController.text = todoList[index].title;
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  void toggleTodoIsDone(Todo todo) {
    final toggledTodo = todo.copyWith(isDone: !todo.isDone);
    todoRepository.updateTodo(toggledTodo);
    fetchTodoList();
  }

  void _resetTodoInput() {
    isAddingNewTodo.value = false;
    editingTodoIndex.value = null;
    textEditingController.clear();
  }
}
