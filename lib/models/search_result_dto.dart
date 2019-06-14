import 'package:spike_bloc_flutter/models/repo_entity.dart';

class SearchResultDto {
  const SearchResultDto({
    this.totalCount = 0,
    this.isIncompleteResults = true,
    this.items = const [],
  });

  final int totalCount;
  final bool isIncompleteResults;
  final List<RepoEntity> items;

  factory SearchResultDto.fromJson(Map<String, dynamic> json) {
    List<RepoEntity> repoList = [];
    for (var repo in json['items']) {
      repoList.add(RepoEntity.fromJson(repo));
    }

    return SearchResultDto(
      totalCount: json['total_count'],
      isIncompleteResults: json['incomplete_results'],
      items: repoList,
    );
  }
}
