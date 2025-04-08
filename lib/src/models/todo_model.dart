class TodoModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final bool status;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  factory TodoModel.fromMap(Map<String, dynamic> data) {
    return TodoModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      date: data['date'],
      status: data['status'] == 1,
    );
  }
}
