class TodoModel {
  int? index;
  String title;
  bool status;

  TodoModel({
    required this.title,
    this.index,
    this.status = false
    });

  copyWith({required bool completed}) {}
}
