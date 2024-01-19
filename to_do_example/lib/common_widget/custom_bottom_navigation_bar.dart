import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_example/common_widget/controllers/navigation_controller.dart';
import 'package:to_do_example/constant/app_color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find();
    return Obx(
      () => BottomNavigationBar(
        onTap: navigationController.changeIndex,
        currentIndex: navigationController.selectedIndex.value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_rounded),
            label: 'Done',
          ),
        ],
        selectedItemColor: AppColor.theme,
        unselectedItemColor: AppColor.deactivated,
      ),
    );
  }
}
