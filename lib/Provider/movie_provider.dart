import 'package:flutter/widgets.dart';
import 'package:movie_apicall/Model/movie_model.dart';
import 'package:movie_apicall/Utils/api_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class MovieProvider extends ChangeNotifier {

  String movieName="";

  Future<MovieModel> getMovieData(String name) async {
    Apihelper apihelper = Apihelper();
    MovieModel movieModel = await apihelper.getMovieApi(movieName);
    return movieModel;
  }

  Future<void> permission() async {
    var Status = await[
      Permission.camera,
      Permission.location,
      Permission.storage,
    ].request();
  }
  void changeName(String name)
  {
    movieName = name;
    notifyListeners();
  }
}
