import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool isDone;
  @HiveField(3)
  int orderIndex;

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
    required this.orderIndex,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
    int? orderIndex,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
