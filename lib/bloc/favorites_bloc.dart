import 'dart:async';

import 'package:spike_bloc_flutter/models/repo_entity.dart';

class FavoritesBloc {
  final _valueController = StreamController<List<RepoEntity>>();

  Stream<List<RepoEntity>> get value => _valueController.stream;

  void onFavoriteChanged(RepoEntity target, List<RepoEntity> items) {
    if (items.contains(target)) {
      items.remove(target);
    } else {
      items.add(target);
    }

    _valueController.sink.add(items);
  }

  void dispose() {
    _valueController.close();
  }
}
