import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:spike_bloc_flutter/bloc/favorites_bloc.dart';
import 'package:spike_bloc_flutter/bloc/github_bloc.dart';
import 'package:spike_bloc_flutter/models/repo_entity.dart';
import 'package:spike_bloc_flutter/models/search_result_dto.dart';

import 'widgets/loading_widget.dart';

class GithubListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GithubListState();
  }
}

class GithubListState extends State<StatefulWidget> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('GitHub検索'),
      actions: <Widget>[
        searchBar.getSearchAction(context),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    var githubBloc = Provider.of<GithubBloc>(context, listen: false);
    searchBar = SearchBar(
        inBar: false,
        setState: (fn) => fn(), // searchbar表示のため
        onSubmitted: (freeWord) => githubBloc.fetch(freeWord),
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    var githubBloc = Provider.of<GithubBloc>(context, listen: false);
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: searchBar.build(context),
          body: StreamBuilder<SearchResultDto>(
            initialData: SearchResultDto(),
            stream: githubBloc.value,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.items.length > 1) {
                var dto = snapshot.data;
                final favoritesBloc = Provider.of<FavoritesBloc>(context);
                return StreamBuilder<List<RepoEntity>>(
                    initialData: [],
                    stream: favoritesBloc.value,
                    builder: (context, snapshot) {
                      return ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: dto.items.length,
                          itemBuilder: (context, i) {
                            return _buildRow(context, dto.items[i], snapshot.data);
                          });
                    });
              } else if (snapshot.hasError) {
                // TODO エラー用の画面
              }
              return Container();
            },
          ),
        ),
        const LoadingWidget(),
      ],
    );
  }

  Widget _buildRow(BuildContext context, RepoEntity entity, List<RepoEntity> items) {
    bool isFavorite = items.contains(entity);
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                entity.fullName,
                style: _biggerFont,
              ),
              subtitle: Text(entity.stars.toString()),
              trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    final favoritesBloc = Provider.of<FavoritesBloc>(context);
                    favoritesBloc.onFavoriteChanged(entity, items);
                  }),
              onTap: () {
                // TODO 何か処理
              }),
          Divider(),
        ],
      ),
    );
  }
}
