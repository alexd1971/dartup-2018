import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:models/models.dart' as models;

class VideoMovieDetails extends StatelessWidget {

  final models.VideoMovieDetails videoMovieDetails;

  VideoMovieDetails(this.videoMovieDetails);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(videoMovieDetails.title),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Table(
            columnWidths: {
              0: IntrinsicColumnWidth()
            },
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  DetailName('Type'),
                  DetailValue(videoMovieDetails.type.json)
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Title'),
                  DetailValue(videoMovieDetails.title)
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Release date'),
                  DetailValue(DateFormat.yMd().format(videoMovieDetails.released))
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Run time'),
                  DetailValue(videoMovieDetails.runtime.toString())
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Countries'),
                  DetailValue(videoMovieDetails.countries.join(', '))
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Genres'),
                  DetailValue(videoMovieDetails.genres.join(', '))
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Director'),
                  DetailValue(videoMovieDetails.director)
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Writers'),
                  DetailValue(videoMovieDetails.writers.join(', '))
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Actors'),
                  DetailValue(videoMovieDetails.actors.join(', '))
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Plot'),
                  DetailValue(videoMovieDetails.plot)
                ]
              ),
              TableRow(
                children: <Widget>[
                  DetailName('Poster'),
                  Image.network(videoMovieDetails.poster)
                ]
              ),
            ],
          )
        ),
      ) 
    );
}

class DetailName extends StatelessWidget {
  final String text;
  DetailName(this.text);

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(text,
        style: Theme.of(context).textTheme.body2
      )
    );
}

class DetailValue extends StatelessWidget {
  final String text;
  DetailValue(this.text);

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(text,
        style: Theme.of(context).textTheme.body1
      )
    );
}