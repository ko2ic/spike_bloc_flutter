import 'dart:async';

import 'package:graphql/client.dart';
import 'package:spike_bloc_flutter/models/search_result_dto.dart';

class GithubHttpClient {
  // 次のページで作成したトークンを設定する [https://github.com/settings/tokens/]
  static const _YOUR_PERSONAL_ACCESS_TOKEN = 'TODO';

  static const _search = r'''
query ($freeWord: String!) {
  search(query: $freeWord, type:REPOSITORY, first:10) { 
    codeCount
    edges {
      node {
      	... on Repository{
      	  name
        	nameWithOwner          
          stargazers {
            totalCount
          }
      	} 
      }      
    }
  	pageInfo{
      hasNextPage
    }
  }
}
''';

  final HttpLink _httpLink = HttpLink(
    uri: 'https://api.github.com/graphql',
  );

  final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $_YOUR_PERSONAL_ACCESS_TOKEN',
  );

  Future<SearchResultDto> fetch(String freeWord) async {
    final Link _link = _authLink.concat(_httpLink as Link);

    final GraphQLClient _client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );

    final QueryOptions options = QueryOptions(
      document: _search,
      variables: <String, dynamic>{
        'freeWord': freeWord,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasErrors) {
      print(result.errors);
      return Future.error(result.errors);
    }

    return SearchResultDto.fromJson(result.data['search']);
  }
}
