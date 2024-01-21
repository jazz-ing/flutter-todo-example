# Flutter To-Do List 앱

<p align="left">  
  <img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/c707867c-e400-4183-a3fc-f8cee47b0842" width="220" height="500"> 
  <img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/239c3930-97cd-4753-957b-2cf62187fd65" width="220" height="500"> 
  <img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/c2619741-92a6-4bcc-b8f6-53564882c836" width="220" height="500">
</p>

## 기술 스택
|분류|사용 기술|
|------|---|
|UI|· Flutter|
|State Management|· GetX|
|Database|· Hive|

## 기능 개요
### 할 일 생성/수정/삭제
- 생성[(구현방식으로 이동)](#생성)    
<img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/d748a7f3-4019-427e-afd6-217c9680096f" width="220" height="500"> <br>
  - Navigation Bar의 '+' 버튼을 누르면 텍스트 필드가 추가되며 입력할 수 있습니다.
  - 아무것도 입력하지 않고 '완료' 버튼을 누르면 생성되지 않습니다.

- 수정  
<img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/6b48c52c-424a-4dd7-b220-e0bb20a298df" width="220" height="500"> <br>
  - 할 일을 누르면 바로 수정할 수 있도록 텍스트필드가 활성화됩니다.
  - 생성할 때와 마찬가지로 '완료' 버튼을 누르면 저장됩니다.

- 삭제  
<img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/f20ac899-6470-445b-96d6-8e8d72b9c7b5" width="220" height="500"> <br>
  - 복잡하지 않은 UI를 위해 Swipe to Delete로 삭제를 구현했습니다.

### 완료된 할 일 이동하기  
<img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/fe941f3b-9238-485b-8334-e5e2ae2123c5" width="220" height="500"> <br>
  - 아이콘을 탭하면 완료 리스트로 해당 할 일이 이동됩니다.

### 순서 바꾸기
  <img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/a818cbe0-4b08-47df-9d48-a5fee055d3ec" width="220" height="500"> <br>
  - 할 일을 길게 탭할 시 순서 이동을 할 수 있습니다.

## 구현 방식
### 설계
<img src="https://github.com/jazz-ing/ios-nala-market/assets/78457093/c913b2f5-c318-4df5-acda-3336f1c76b07" width="50%"> <br>
- Clean Architecture의 Presentation-Domain-Data레이어 적용
- abstract class를 이용해 TodoRepository를 추상화해 테스트가 용이하도록 구현
  ```dart
  abstract class TodoRepository {
    Future<List<Todo>> getTodoList();
    Future<void> createTodo(Todo todo);
    Future<void> deleteTodo(Todo todo);
    Future<void> updateTodo(Todo todo);
    Future<void> reorderTodo(int oldIndex, int newIndex);
  }
  ```

### 할 일 생성/수정/삭제


### 순서 이동
- `Todo` Entity에 `orderIndex` 프로퍼티를 추가해 객체 자체에서 순서 정보를 관리할 수 있도록 구현
```dart
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

  Todo({ //... });

  Todo copyWith({ //... }) {
    return Todo( //... );
  }
}
```
- `ReorderableListView`를 이용해 드래그앤 드롭 구현
```dart
ReorderableListView.builder(
  // ... 기타 ReorderableListView 빌드에 필요한 프로퍼티 (itemCount, shrinkWrap)
  itemBuilder: (context, index) {
    // ... 생성, 수정 시 TextField를 보여주는 코드
    return TodoRow(
      key: Key('order_${todo.id}'),
      todo: todo,
      onButtonTap: () => controller.toggleTodoIsDone(todo),
      onEdit: () => controller.startTodoEditing(index),
      onDelete: () => controller.deleteTodo(todo),
    );
  },
  onReorder: (oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    controller.reorderTodoList(oldIndex, newIndex);
  },
);
```
