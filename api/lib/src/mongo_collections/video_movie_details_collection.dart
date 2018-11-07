import 'package:rest_api_server/mongo_collection.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:models/models.dart';

class VideoMovieDetailsCollection extends MongoCollection<VideoMovieDetails, VideoDetailsId> {
  
  VideoMovieDetailsCollection(mongo.DbCollection collection): super(collection);

  @override
  VideoMovieDetails createModel(Map<String, dynamic> data) => VideoMovieDetails.fromJson(data);
}
