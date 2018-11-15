import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:mongo_dart/mongo_dart.dart';

DbCollection collection;

main(List<String> args) async {
  var parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '7777');

  var result = parser.parse(args);

  var port = int.tryParse(result['port']);

  if (port == null) {
    stdout.writeln(
        'Could not parse port value "${result['port']}" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  final db = Db('mongodb://localhost:27017/VideoMovies');
  await db.open();
  collection = db.collection('video_movies');

  var server = await io.serve(handler, InternetAddress.loopbackIPv4, port);
  print('Serving at http://${server.address.host}:${server.port}');
}

Future<shelf.Response> handler(shelf.Request request) async {
  final result = await collection.aggregateToStream(
    [
      {
        '\$addFields': {
          'id': {'\$toString': '\$_id'}
        }
      },
      {
        '\$project': {
          '_id': false,
        }
      },
      {
      '\$skip': 10
      },
      {
      '\$limit': 10
      }
    ]
  ).toList();
  return new shelf.Response.ok(
    json.encode(result),
    headers: {
      'content-type': 'application/json'
    }
  );
}
