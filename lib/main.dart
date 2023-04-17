import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/movie_provider.dart';
import 'View/home_screen.dart';

void main() {
  runApp(MultiProvider(\
    providers: [
      ChangeNotifierProvider(
        create: (context) => MovieProvider(),
      ),
    ],
    child: MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
      },
    ),
  ));
}
