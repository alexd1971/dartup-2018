import 'package:flutter/material.dart';
import 'video_movies_list.dart';
import 'package:video_movies_client/video_movies_client.dart';
import 'package:rest_api_client/rest_api_client.dart';
import 'package:http/http.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: new VideoMovieList(
        title: 'Video movies',
        videoMoviesClient: VideoMoviesClient(ApiClient(Uri.http('localhost:3333',''), IOClient()))
      ),
    );
  }
}