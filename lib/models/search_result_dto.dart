import 'package:spike_bloc_flutter/models/repo_entity.dart';

class SearchResultDto {
  const SearchResultDto({
    this.totalCount = 0,
    this.items = const [],
  });

  final int totalCount;

  final List<RepoEntity> items;

  factory SearchResultDto.fromJson(Map<String, dynamic> json) {
    List<RepoEntity> repoList = [];
    for (var repo in json['edges']) {
      repoList.add(RepoEntity.fromJson(repo['node']));
    }

    return SearchResultDto(
      totalCount: json['repositoryCount'],
      items: repoList,
    );
  }
}
