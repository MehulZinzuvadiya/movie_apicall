import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:random_user_apicall/Model/random_model.dart';
import 'package:random_user_apicall/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? homeProviderT;
  HomeProvider? homeProviderF;

  @override
  Widget build(BuildContext context) {
    homeProviderT = Provider.of<HomeProvider>(context, listen: true);
    homeProviderF = Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Random User",
              style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
            ),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Center(
              //   child: IconButton(
              //       onPressed: () {
              //         setState(() {});
              //       },
              //       icon: Icon(
              //         Icons.refresh,
              //         color: Colors.green.shade700,
              //       )),
              // ),
              Expanded(
                child: FutureBuilder(
                  future: homeProviderT!.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      RandomModel? rm2 = snapshot.data;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          // return ListTile(
                          //   leading: CircleAvatar(
                          //     radius: 60,
                          //     backgroundImage:
                          //         NetworkImage(rm2!.results[index].picture.medium),
                          //     backgroundColor: Colors.transparent,
                          //   ),
                          //   title: Text("${rm2!.results[index].name.first}"),
                          //   subtitle:
                          //       Text("${rm2!.results[index].location.country}"),
                          // );

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 64.0,
                                    backgroundImage: NetworkImage(
                                        rm2!.results[index].picture.medium),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    "${rm2!.results[index].name.first}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    "${rm2!.results[index].location.country}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 32.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(),
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "${rm2!.results[index].email}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        Text(
                                          "Date of Birth",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "${rm2!.results[index].dob.date}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        Text(
                                          "Phone Number",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          "${rm2!.results[index].phone}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 32.0),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: rm2!.results.length,
                      );
                    }
                    return Container(child: CircularProgressIndicator());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(80),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Refresh"),
                ),
              ),
            ],
          ),
        ));
  }
}