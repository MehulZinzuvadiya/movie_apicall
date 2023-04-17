import 'package:flutter/widgets.dart';
import 'package:movie_apicall/Model/movie_model.dart';
import 'package:movie_apicall/Utils/api_helper.dart';

class MovieProvider extends ChangeNotifier {
  Future<MovieModel> getMovieData() async {
    Apihelper apihelper = Apihelper();
    MovieModel movieModel = await apihelper.getMovieApi();
    return movieModel;
  }
}
