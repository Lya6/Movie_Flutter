import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/movie_response.dart';
import 'package:flutter_movie_db/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesByGenreListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async {
    MovieResponse response = await _repository.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesByGenreBloc = MoviesByGenreListBloc();
