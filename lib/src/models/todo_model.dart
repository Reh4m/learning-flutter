enum TodoStatus { done, notDone, inProgress }

class TodoModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final TodoStatus status;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'status': status,
    };
  }
}
