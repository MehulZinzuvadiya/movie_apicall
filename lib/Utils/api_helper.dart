import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_apicall/Model/movie_model.dart';

class Apihelper {
  Future<MovieModel> getMovieApi(String name) async {
    String apiLink =
        "https://imdb8.p.rapidapi.com/auto-complete?q=$name";
    Uri uri = Uri.parse(apiLink);
    var response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'e1ce1db1b6mshd5301ab816f5ff7p133682jsnd4862ef0f16d',
      'X-RapidAPI-Host': 'imdb8.p.rapidapi.com'
    });
    var json = jsonDecode(response.body);

    MovieModel movieModel = MovieModel.fromJson(json);

    return movieModel;
  }
}