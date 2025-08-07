import 'package:flutter/material.dart';
import 'package:hello_pokemon/app/modules/core/models/pokemon_detail_model.dart';
import 'package:hello_pokemon/app/modules/core/utils/get_type_color.dart';

class PokemonDetailItem extends StatelessWidget {
  final PokemonDetailModel pokemon;
  final VoidCallback? onTap;

  const PokemonDetailItem({super.key, required this.pokemon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: pokemon.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          pokemon.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackAvatar();
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      )
                    : _buildFallbackAvatar(),
              ),
              const SizedBox(width: 16),
              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pokemon.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '#${pokemon.id.toString().padLeft(3, '0')}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (pokemon.types.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        children: pokemon.types
                            .map(
                              (type) => Chip(
                                label: Text(
                                  type,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                backgroundColor: getTypeColor(type),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    const SizedBox(height: 8),
                    // Altura e Peso
                    Row(
                      children: [
                        Icon(Icons.height, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${(pokemon.height / 10).toStringAsFixed(1)}m',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.monitor_weight,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${(pokemon.weight / 10).toStringAsFixed(1)}kg',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Ícone para indicar que é clicável
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: getTypeColor(
        pokemon.types.isNotEmpty ? pokemon.types.first : 'normal',
      ),
      child: Text(
        pokemon.name.isNotEmpty ? pokemon.name[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
