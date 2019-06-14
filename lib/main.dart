import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/favorites_bloc.dart';
import 'bloc/github_bloc.dart';
import 'bloc/loading_bloc.dart';
import 'repositories/github_repository_impl.dart';
import 'ui/github_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static GithubRepository repository = GithubRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: MultiProvider(
        providers: [
          Provider(
            builder: (_) => LoadingBloc(),
            dispose: (_, bloc) => bloc.dispose(),
          ),
          Provider(
            builder: (context) {
              var bloc = Provider.of<LoadingBloc>(context, listen: false);
              return GithubBloc(GithubRepository(), bloc);
            },
            dispose: (_, bloc) => bloc.dispose(),
          ),
          Provider(
            builder: (_) => FavoritesBloc(),
            dispose: (_, bloc) => bloc.dispose(),
          ),
        ],
        child: GithubListPage(),
      ),
    );
  }
}
