import 'package:dio/dio.dart';
import 'package:learning_flutter/secret/keys.dart' as secret;
import 'package:learning_flutter/src/models/popular_model.dart';

class PopularApi {
  final dio = Dio();

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
