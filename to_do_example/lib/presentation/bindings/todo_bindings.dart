import 'package:get/get.dart';
import 'package:to_do_example/data/datasources/local_todo_data_source.dart';
import 'package:to_do_example/data/repositories/local_todo_repository.dart';
import 'package:to_do_example/data/repositories/todo_repository.dart';
import 'package:to_do_example/presentation/controllers/todo_controller.dart';

class TodoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalTodoDataSource>(() => LocalTodoDataSource());
    Get.lazyPut<TodoRepository>(
        () => LocalTodoRepository(Get.find<LocalTodoDataSource>()));
    Get.lazyPut<TodoController>(
        () => TodoController(todoRepository: Get.find<TodoRepository>()));
  }
}
