import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_example/data/repositories/todo_repository.dart';
import 'package:to_do_example/domain/todo/todo.dart';

class TodoController extends GetxController {
  final TodoRepository todoRepository;
  final TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  TodoController({required this.todoRepository});

  final todoList = <Todo>[].obs;
  final isAddingNewTodo = false.obs;
  final editingTodoIndex = Rx<int?>(null);
  final newTodoKey = RxString('');

  RxList<Todo> get pendingTodos =>
      todoList.where((todo) => !todo.isDone).toList().obs;
  RxList<Todo> get doneTodos =>
      todoList.where((todo) => todo.isDone).toList().obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodoList();
  }

  Future<void> fetchTodoList() async {
    final todoList = await todoRepository.getTodoList();
    this.todoList.value = todoList;
  }

  void handleTodoSubmit({required String text}) {
    final isEditing = editingTodoIndex.value != null;
    if (isEditing) {
      editTodo(text: text);
    } else {
      createTodo(text: text);
    }
    _resetTodoInput();
  }

  void createTodo({required String text}) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: text,
      isDone: false,
      orderIndex: todoList.length,
    );
    if (text.isNotEmpty) {
      todoRepository.createTodo(todo);
      fetchTodoList();
    }
  }

  void editTodo({required String text}) {
    final todo = pendingTodos[editingTodoIndex.value!].copyWith(title: text);
    todoRepository.updateTodo(todo);
    fetchTodoList();
  }

  void deleteTodo(Todo todo) {
    todoRepository.deleteTodo(todo);
    fetchTodoList();
  }

  void initiateNewTodo() {
    newTodoKey.value = 'new-todo-${DateTime.now().millisecondsSinceEpoch}';
    editingTodoIndex.value = null;
    isAddingNewTodo.value = true;
    textEditingController.clear();
    focusNode.requestFocus();
  }

  void startTodoEditing(int index) {
    editingTodoIndex.value = index;
    textEditingController.text = pendingTodos[index].title;
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  Future<void> toggleTodoIsDone(Todo todo) async {
    final toggledTodo = todo.copyWith(isDone: !todo.isDone);
    await todoRepository.updateTodo(toggledTodo);
    fetchTodoList();
  }

  Future<void> reorderTodoList(int oldIndex, int newIndex) async {
    await todoRepository.reorderTodo(oldIndex, newIndex);
    fetchTodoList();
  }

  void _resetTodoInput() {
    isAddingNewTodo.value = false;
    editingTodoIndex.value = null;
    textEditingController.clear();
  }
}
