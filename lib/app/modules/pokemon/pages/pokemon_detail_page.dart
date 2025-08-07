import 'package:flutter/material.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/core/widgets/custom_loader.dart';
import 'package:hello_pokemon/app/modules/pokemon/controller/pokemon_detail_list_controller.dart';

class PokemonDetailPage extends StatefulWidget {
  final PokemonDetailListController controller;
  final int initialIndex;

  const PokemonDetailPage({
    super.key,
    required this.controller,
    required this.initialIndex,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late PageController _pageController;
  late PokemonDetailListController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });

    // Quando estiver próximo do final da lista, carrega mais pokémons
    if (index >= controller.pokemons.length - 3 &&
        controller.hasMore &&
        !controller.isLoading) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            if (currentIndex < controller.pokemons.length) {
              final pokemon = controller.pokemons[currentIndex];
              return Text(
                pokemon.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
            return CustomLoader();
          },
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.pokemons.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount:
                controller.pokemons.length + (controller.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.pokemons.length) {
                return _buildPokemonDetail(controller.pokemons[index]);
              } else if (controller.hasMore) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Widget _buildPokemonDetail(PokemonDetailModel pokemon) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Imagem do Pokémon
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _getTypeColor(
                    pokemon.types.isNotEmpty ? pokemon.types.first : 'normal',
                  ).withValues(alpha: 0.8),
                  _getTypeColor(
                    pokemon.types.isNotEmpty ? pokemon.types.first : 'normal',
                  ).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: pokemon.imageUrl != null
                ? Image.network(
                    pokemon.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.catching_pokemon,
                        size: 150,
                        color: Colors.white,
                      );
                    },
                  )
                : const Icon(
                    Icons.catching_pokemon,
                    size: 150,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(height: 20),

          // Informações básicas
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // ID e Nome
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tipos
                if (pokemon.types.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: pokemon.types
                        .map(
                          (type) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getTypeColor(type),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 20),

                // Altura e Peso
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        'ALTURA',
                        '${(pokemon.height / 10).toStringAsFixed(1)} m',
                        Icons.height,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoCard(
                        'PESO',
                        '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                        Icons.monitor_weight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Stats
                if (pokemon.stats.isNotEmpty) ...[
                  const Text(
                    'ESTATÍSTICAS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...pokemon.stats.map((stat) => _buildStatBar(stat)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Indicador de navegação
          Text(
            'Deslize para ver outros Pokémons',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[600], size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(PokemonStat stat) {
    final percentage = (stat.baseStat / 255).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              stat.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getStatColor(percentage),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text(
              stat.baseStat.toString(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatColor(double percentage) {
    if (percentage > 0.8) return Colors.green;
    if (percentage > 0.6) return Colors.orange;
    if (percentage > 0.4) return Colors.yellow[700]!;
    return Colors.red;
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow[700]!;
      case 'psychic':
        return Colors.pink;
      case 'ice':
        return Colors.lightBlue;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink[300]!;
      case 'fighting':
        return Colors.red[800]!;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.orange[800]!;
      case 'flying':
        return Colors.blue[300]!;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey[600]!;
      case 'ghost':
        return Colors.deepPurple;
      case 'steel':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
