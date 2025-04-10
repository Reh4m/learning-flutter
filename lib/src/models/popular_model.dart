class PopularModel {
  int id;
  String backdropPath;
  List<int> genres;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularModel({
    required this.id,
    required this.backdropPath,
    required this.genres,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularModel.fromMap(Map<String, dynamic> data) {
    return PopularModel(
      id: data['id'],
      backdropPath: data['backdrop_path'],
      genres: List<int>.from(data['genre_ids']),
      originalLanguage: data['original_language'],
      originalTitle: data['original_title'],
      overview: data['overview'],
      popularity: data['popularity'],
      posterPath: data['poster_path'],
      releaseDate: DateTime.parse(data['release_date']),
      title: data['title'],
      voteAverage: data['vote_average'],
      voteCount: data['vote_count'],
    );
  }
}
