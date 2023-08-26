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
    // Provider.of<MovieProvider>(context, listen: false).getMovieData();
    Provider.of<MovieProvider>(context, listen: false).permission();
  }

  TextEditingController txtName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    movieProviderT = Provider.of<MovieProvider>(context, listen: true);
    movieProviderF = Provider.of<MovieProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "🍿 PopCorn Time",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: txtName,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.deepPurple.shade700,
              decoration: InputDecoration(
                hintText: 'Search Movie..',
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              movieProviderF!.changeName("${txtName.text}");
              movieProviderF!.getMovieData("${txtName.text}");
            },
            child: Text("Search !!"),
          ),
          Expanded(
            child: FutureBuilder(
              future: movieProviderT!.getMovieData(movieProviderF!.movieName),
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
                                "${m1.d[index].l}",
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
