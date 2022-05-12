import 'dart:convert';

import 'package:app_peliculas/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

  String _apiKey= '8e1c917cb7515d71fe826bb1353ae96b';
  String _baseUrl= 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];


  MoviesProvider(){
    print ('CONSTRUCTOR MoviesProvider inicializando');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async{
    var url =
      Uri.https(_baseUrl, '3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'
        });

  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    final nowPlayingResponse = NowPLayingResponse.fromJson(response.body);

   
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();// para redibujar los cambios


  }

}