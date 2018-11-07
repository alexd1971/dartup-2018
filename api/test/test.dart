import 'package:mongo_dart/mongo_dart.dart' as mongo;

main() async {
  final db = mongo.Db('mongodb://127.0.0.1:27017/SampleCollections');
  await db.open();
  final collection = db.collection('video_movies');
  final pipeline = <Map<String, dynamic>>[];
  // pipeline.add({'\$match': null});
  pipeline.addAll([
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
      '\$skip': 0
    },
    {
      '\$limit': 5
    }
  ]);
  final result = await collection.aggregateToStream(pipeline).toList();
  print(result);
  db.close();
  print(mongo.where.paramLimit);
}