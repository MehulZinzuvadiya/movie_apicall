import 'package:flutter/material.dart';
import 'package:movie_apicall/Model/movie_model.dart';
import 'package:movie_apicall/Provider/movie_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieProvider? movieProviderT;
  MovieProvider? movieProviderF;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    movieProviderT = Provider.of<MovieProvider>(context, listen: true);
    movieProviderF = Provider.of<MovieProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Game Of Thrones",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: movieProviderT!.getMovieData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  MovieModel? m1 = snapshot.data;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundImage: m1.d[index].i == null
                                    ? NetworkImage(
                                        'https://wallpapercave.com/wp/wp2131690.jpg')
                                    : NetworkImage(m1.d[index].i!.imageUrl),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "${m1!.d[index].l}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: m1!.d.length,
                  );
                }
                return Container(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    ));
  }
}
