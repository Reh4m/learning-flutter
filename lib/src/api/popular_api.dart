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

      List genres = response.data['genres'];

      return genres.map((genre) => MovieGenreModel.fromMap(genre)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<PopularModel>> getHttpPopular() async {
    try {
      Response response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=${secret.themoviedbApi}&language=en-US&page=1',
      );

      List popularMovies = response.data['results'];

      return popularMovies.map((movie) => PopularModel.fromMap(movie)).toList();
    } catch (e) {
      return [];
    }
  }
}
