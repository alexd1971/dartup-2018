package dartup.sample.mongo_collections;

import java.util.*;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Projections;
import com.mongodb.client.model.Field;

import org.bson.Document;
import org.bson.conversions.Bson;

import dartup.sample.models.VideoMovie;

public class VideoMoviesCollection {
  private final MongoCollection<VideoMovie> collection;

  public VideoMoviesCollection(MongoCollection<VideoMovie> collection) {
    this.collection = collection;
  }

  public AggregateIterable<VideoMovie> find() {
    List<Bson> pipeline = Arrays.asList(
      Aggregates.addFields(
        new Field<Document>("id", new Document("$toString", "$_id"))
      ),
      Aggregates.project(Projections.excludeId()),
      Aggregates.skip(10),
      Aggregates.limit(10)
    );
    return collection.aggregate(pipeline);
  }

}
