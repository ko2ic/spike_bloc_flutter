import 'dart:async';

import 'package:spike_bloc_flutter/models/search_result_dto.dart';
import 'package:spike_bloc_flutter/repositories/github_repository_impl.dart';

import 'loading_bloc.dart';

class GithubBloc {
  final GithubRepository repository;
  final LoadingBloc loadingBloc;

  GithubBloc(this.repository, this.loadingBloc) {
    fetch("flutter");
  }

  final _valueController = StreamController<SearchResultDto>();

  Stream<SearchResultDto> get value => _valueController.stream;

  void fetch(String freeWord) {
    loadingBloc.loading(true);
    var stream = repository.fetch(freeWord).whenComplete(() {
      loadingBloc.loading(false);
    }).asStream();
    _valueController.sink.addStream(stream);
  }

  void dispose() {
    _valueController.close();
  }
}
