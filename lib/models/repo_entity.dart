class RepoEntity {
  const RepoEntity({
    this.name,
    this.fullName,
    this.stars,
  });

  final String name;
  final String fullName;
  final int stars;

  factory RepoEntity.fromJson(Map<String, dynamic> json) {
    return RepoEntity(
      name: json['name'],
      fullName: json['nameWithOwner'],
      stars: json['stargazers']['totalCount'],
    );
  }

  RepoEntity copyWith({
    final String name,
    final String fullName,
    final int stars,
  }) {
    return RepoEntity(
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      stars: stars ?? this.stars,
    );
  }
}
