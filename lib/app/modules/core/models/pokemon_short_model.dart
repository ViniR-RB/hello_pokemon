class PokemonShortModel {
  final String name;
  final String url;

  PokemonShortModel({required this.name, required this.url});

  factory PokemonShortModel.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {'name': final name, 'url': final url} => PokemonShortModel(
        name: name,
        url: url,
      ),
      _ => throw ArgumentError('Invalid map $map'),
    };
  }
}
