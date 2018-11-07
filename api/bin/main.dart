import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;
import 'package:rest_api_server/api_server.dart';
import 'package:rest_api_server/http_exception_middleware.dart';
import 'package:rest_api_server/cors_headers_middleware.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'package:api/api.dart';
import 'package:api/collections.dart';


main() async {

  final db = mongo.Db('mongodb://video-movies-db:27017/VideoMovies');
  await db.open();

  final router = Router();
  router.add(Api(
      VideoMovies(
        VideoMoviesCollection(db.collection('video_movies')),
        VideoMovieDetails(VideoMovieDetailsCollection(db.collection('video_movieDetails')))
      )
    )
  );

  final server = ApiServer(
    address: InternetAddress.anyIPv4,
    port: 3333,
    handler: shelf.Pipeline()
      .addMiddleware(HttpExceptionMiddleware())
      .addMiddleware(CorsHeadersMiddleware({
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Expose-Headers': 'Authorization, Content-Type',
        'Access-Control-Allow-Headers':
            'Authorization, Origin, X-Requested-With, Content-Type, Accept, Content-Disposition',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE'
      }))
      .addHandler(router.handler)
  );

  await server.start();
  router.printRoutes();
}