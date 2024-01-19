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

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
  });
}
