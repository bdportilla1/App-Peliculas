
import 'package:app_peliculas/models/models.dart';
import 'package:app_peliculas/models/search_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

  String _apiKey= '8e1c917cb7515d71fe826bb1353ae96b';
  String _baseUrl= 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];


  Map<int, List<Cast>> moviesCast = {};


  int _popularPage = 0;


  MoviesProvider(){
    print ('CONSTRUCTOR MoviesProvider inicializando');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String>_getJsonData(String endpoint, {int page = 1}) async{
    var url =
      Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'
        });
  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }


  getOnDisplayMovies() async{
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPLayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();// para redibujar los cambios
  }

  getPopularMovies() async{
    _popularPage  ++;
    final jsonData = await _getJsonData('3/movie/popular', page: _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();// para redibujar los cambios
  }

  Future<List<Cast>> getMovieCast(int movieId) async{

    if(moviesCast.containsKey(movieId)){
      // interrogacion porque estoy seguro de que es de ese tipo
      return moviesCast[movieId]!;
    }
    // probar cuando solicita http
    /*
    print('solicitando acotres');
    print('El id de la peli es: $movieId');*/
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async{
    final url =
      Uri.https(_baseUrl, '3/search/movie', {
        'api_key': _apiKey,
        'query': query
        });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }



}