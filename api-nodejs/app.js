var express = require('express');
var app = express();
var mongoClient = require('mongodb').MongoClient;
var collection;

mongoClient.connect('mongodb://localhost:27017/', function(err, client){
  if (err) console.log(err);

  var db = client.db('VideoMovies');
  collection = db.collection('video_movies');
});
app.get('/', function (req, res) {
  collection.aggregate([
    {
      $addFields: {
        id: {$toString: '$_id'}
      }
    },
    {
      $project: {
        _id: false
      }
    },
    {
      $skip: 10
    },
    {
      $limit: 10
    }
  ]).toArray(function (err, result) {
    if (err) console.log(err);
    result = result.map(function(obj) {return new VideoMovie(obj);});
    res.send(result);
  });
});

app.listen(5555, function () {
  console.log('Example app listening on port 5555!');
});

class VideoMovie {
  constructor(json) {
    this.id = json._id;
    this.title = json.title;
    this.year = json.year;
    this.imdb = json.imdb;
    this.type = json.type;
  }
}
