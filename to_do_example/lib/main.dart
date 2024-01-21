import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_example/common_widget/controllers/navigation_controller.dart';
import 'package:to_do_example/common_widget/custom_bottom_navigation_bar.dart';
import 'package:to_do_example/constant/app_color.dart';
import 'package:to_do_example/domain/todo/todo.dart';
import 'package:to_do_example/presentation/bindings/todo_bindings.dart';
import 'package:to_do_example/presentation/pages/done_list_page.dart';
import 'package:to_do_example/presentation/pages/todo_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Get.put(NavigationController());
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter ToDo Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.theme),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColor.theme,
          unselectedItemColor: Colors.grey,
        ),
      ),
      initialBinding: TodoBindings(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find();

    final List<Widget> screens = [
      const TodoListPage(),
      const DoneListPage(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: navigationController.selectedIndex.value,
          children: screens,
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
