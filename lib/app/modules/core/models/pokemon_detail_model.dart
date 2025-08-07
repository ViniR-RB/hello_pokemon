class PokemonDetailModel {
  final int id;
  final String name;
  final String? imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final List<PokemonStat> stats;

  PokemonDetailModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
  });

  factory PokemonDetailModel.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        "id": final int? id,
        "name": final String? name,
        "sprites": final Map<String, dynamic>? sprites,
        "height": final int? height,
        "weight": final int? weight,
        "types": final List<dynamic>? types,
        "stats": final List<dynamic>? stats,
      } =>
        PokemonDetailModel(
          id: id ?? 0,
          name: name ?? '',
          imageUrl:
              sprites?['other']?['official-artwork']?['front_default'] ??
              sprites?['front_default'],
          height: height ?? 0,
          weight: weight ?? 0,
          types: (types ?? [])
              .map((type) => type['type']['name'] as String)
              .toList(),
          stats: (stats ?? [])
              .map((stat) => PokemonStat.fromMap(stat as Map<String, dynamic>))
              .toList(),
        ),
      _ => throw ArgumentError('Invalid map data for PokemonDetailModel $map'),
    };
  }
}

class PokemonStat {
  final String name;
  final int baseStat;

  PokemonStat({required this.name, required this.baseStat});

  factory PokemonStat.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'stat': final Map<String, dynamic> stat,
        'base_stat': final int baseStat,
      } =>
        PokemonStat(name: stat['name'] ?? '', baseStat: baseStat),
      _ => throw ArgumentError('Invalid map data for PokemonStat $map'),
    };
  }
}
