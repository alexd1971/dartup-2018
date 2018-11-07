package dartup.sample.mongo_collections;

import org.bson.BsonReader;
import org.bson.BsonType;
import org.bson.BsonWriter;
import org.bson.Document;
import org.bson.codecs.Codec;
import org.bson.codecs.DecoderContext;
import org.bson.codecs.EncoderContext;

import dartup.sample.models.VideoMovie;

public class VideoMovieCodec implements Codec<VideoMovie> {

  @Override
  public Class<VideoMovie> getEncoderClass() {
    return VideoMovie.class;
  }

  @Override
  public void encode(BsonWriter writer, VideoMovie v, EncoderContext ec) {
    Document doc = new Document();
    doc.append("id", v.id.toString());
    doc.append("title", v.title);
    doc.append("year", v.year);
    doc.append("imdb", v.imdb);
    doc.append("type", v.type);
    writer.writeString(doc.toJson());
  }

  @Override
  public VideoMovie decode(BsonReader reader, DecoderContext dc) {
    Document doc = new Document();
    reader.readStartDocument();
    do {
      String key = reader.readName();
      switch (reader.getCurrentBsonType()) {
        case STRING:
          doc.put(key, reader.readString());
          break;
        case INT32:
          doc.put(key, reader.readInt32());
          break;
        default:
      }
    } while(reader.readBsonType() != BsonType.END_OF_DOCUMENT);
    reader.readEndDocument();
    VideoMovie v = new VideoMovie();
    v.id = doc.getString("id");
    v.title = doc.getString("title");
    v.year = doc.getInteger("year");
    v.imdb = doc.getString("imdb");
    v.type = doc.getString("type");
    return v;
  }
}