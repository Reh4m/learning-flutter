import 'package:dio/dio.dart';
import 'package:learning_flutter/secret/keys.dart' as secret;
import 'package:learning_flutter/src/models/movie_genre_model.dart';
import 'package:learning_flutter/src/models/popular_model.dart';

class PopularApi {
  final dio = Dio();

  Future<List<MovieGenreModel>> getHttpGenres() async {
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=${secret.themoviedbApi}&language=en-US',
      );

      final genres = response.data['genres'] as List;

      return genres.map((genre) => MovieGenreModel.fromMap(genre)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<PopularModel>> getHttpPopular() async {
    try {
      final genres = await getHttpGenres();

      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=${secret.themoviedbApi}&language=en-US&page=1',
      );

      final result = response.data['results'] as List;

      final popularMovies =
          result.map((movie) => PopularModel.fromMap(movie)).toList();

      for (var movie in popularMovies) {
        movie.genres =
            genres.where((genre) => movie.genresId.contains(genre.id)).toList();
      }

      return popularMovies;
    } catch (e) {
      return [];
    }
  }
}
