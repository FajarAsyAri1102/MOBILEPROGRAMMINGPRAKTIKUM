import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  var title, thumbnail, short_description, description;
  var genre, platform, release, cover, gameid, publisher;

  Future getGame(String gameid) async {
    http.Response response = await http.get(
      Uri.parse('https://www.freetogame.com/api/game?id=$gameid'),
    );

    var results = jsonDecode(response.body);

    setState(() {
      this.gameid = gameid;
      title = results['title'];
      thumbnail = results['thumbnail'];
      short_description = results['short_description'];
      description = results['description'];
      genre = results['genre'];
      platform = results['platform'];
      publisher = results['publisher'];
      release = results['release_date'];
      cover = results['screenshots'][0]['image'];
    });
  }

  @override
  void initState() {
    super.initState();
    getGame('475'); // Ambil 1 game default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081C9),
      body: SafeArea(
        child: Center(
          child: gameid == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Tujuan.routeName,
                          arguments: ScreenArguments(
                            cover,
                            title,
                            description,
                            short_description,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Image.network(thumbnail),
                            const SizedBox(height: 15),
                            Text(
                              title,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Genre: $genre"),
                                    Text("Platform: $platform"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Publisher: $publisher"),
                                    Text("Release: $release"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}