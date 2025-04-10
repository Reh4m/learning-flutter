class MovieGenreModel {
  final int id;
  final String name;

  MovieGenreModel({required this.id, required this.name});

  factory MovieGenreModel.fromMap(Map<String, dynamic> data) {
    return MovieGenreModel(id: data['id'], name: data['name']);
  }
}
