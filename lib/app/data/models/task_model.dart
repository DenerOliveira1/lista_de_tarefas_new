import 'dart:convert';

class TaskModel {
  final String id;
  final String title;
  final String details;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.details,
    this.isDone = false,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? details,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      isDone: isDone ?? this.isDone,
    );
  }

  static TaskModel fromString(String task) {
    Map<String, dynamic> json = jsonDecode(task);

    return TaskModel(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      isDone: json['isDone'],
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'details': details,
        'isDone': isDone,
      };
}
