import 'dart:async';
import 'dart:io';
import 'package:rest_api_client/rest_api_client.dart';
import 'package:models/models.dart';
import 'package:path/path.dart';

class VideoMoviesClient extends ResourceClient<VideoMovie> {

  VideoMoviesClient(ApiClient apiClient): super('videomovies', apiClient);

  @override
  VideoMovie createModel(Map<String, dynamic> json) => VideoMovie.fromJson(json);

  @override
  Future<VideoMovie> create(VideoMovie movie, {Map<String, String> headers = const {}}) {
    throw(Exception('Not implemented'));
  }

  @override
  Future<VideoMovie> update(VideoMovie movie, {Map<String, String> headers = const {}}) {
    throw(Exception('Not implemented'));
  }

  @override
  Future<VideoMovie> replace(VideoMovie movie, {Map<String, String> headers = const {}}) {
    throw(Exception('Not implemented'));
  }

  @override
  Future delete(movie, {Map<String, String> headers = const {}}) {
    throw(Exception('Not implemented'));
  }

  Future<int> count() async {
    final response = await apiClient.send(ApiRequest(
      method: RequestMethod.get,
      resourcePath: join(resourcePath, 'count')
    ));
    if (response.statusCode != HttpStatus.ok) return null;
    return response.body;
  }

  Future<VideoMovieDetails> details(ImdbId id) async {
    final response = await apiClient.send(ApiRequest(
      method: RequestMethod.get,
      resourcePath: join(resourcePath, id.json, 'details')
    ));
    if (response.statusCode != HttpStatus.ok) return null;
    return VideoMovieDetails.fromJson(response.body);
  }
}