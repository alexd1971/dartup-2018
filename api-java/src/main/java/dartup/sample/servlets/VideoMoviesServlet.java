package dartup.sample.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import com.mongodb.MongoClientSettings;
import com.mongodb.ConnectionString;

import org.bson.codecs.configuration.CodecRegistries;
import org.bson.codecs.configuration.CodecRegistry;

import com.mongodb.client.MongoCursor;
import dartup.sample.models.VideoMovie;
import dartup.sample.mongo_collections.*;
import com.google.gson.Gson;

@SuppressWarnings("serial")
@WebServlet(name = "VideoMoviesServlet", urlPatterns = { "videomovies" }, loadOnStartup = 1)
public class VideoMoviesServlet extends HttpServlet {
    private final MongoDatabase db;

    public VideoMoviesServlet() {
        CodecRegistry codecRegistry = CodecRegistries.fromRegistries(
            CodecRegistries.fromCodecs(new VideoMovieCodec()),
            MongoClientSettings.getDefaultCodecRegistry()
        );
        MongoClientSettings settings = MongoClientSettings.builder().codecRegistry(codecRegistry).applyConnectionString(new ConnectionString("mongodb://video-movies-db")).build();
        db = MongoClients.create(settings).getDatabase("VideoMovies");
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VideoMoviesCollection videoMovies = new VideoMoviesCollection(db.getCollection("video_movies", VideoMovie.class));
        MongoCursor<VideoMovie> cursor = videoMovies.find().iterator();
        ArrayList<VideoMovie> result = new ArrayList<VideoMovie>();

        while (cursor.hasNext()) {
            result.add(cursor.next());
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(result));
    }
}