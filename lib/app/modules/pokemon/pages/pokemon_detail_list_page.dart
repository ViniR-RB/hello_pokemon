import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_pokemon/app/modules/core/helpers/messages.dart';
import 'package:hello_pokemon/app/modules/pokemon/controller/pokemon_detail_list_controller.dart';
import 'package:hello_pokemon/app/modules/pokemon/widgets/pokemon_detail_item_widget.dart';

class PokemonDetailListPage extends StatefulWidget {
  final PokemonDetailListController controller;
  const PokemonDetailListPage({super.key, required this.controller});

  @override
  State<PokemonDetailListPage> createState() => _PokemonDetailListPageState();
}

class _PokemonDetailListPageState extends State<PokemonDetailListPage>
    with MessageViewMixin {
  late final PokemonDetailListController controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    messageListener(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadMore();
    });

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
          controller.loadMore();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([controller]),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pokédex"),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          body: RefreshIndicator(
            onRefresh: controller.refresh,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < controller.pokemons.length) {
                        return PokemonDetailItem(
                          pokemon: controller.pokemons[index],
                          onTap: () => Modular.to.pushNamed(
                            '/pokemon/detail',
                            arguments: {"initialIndex": index},
                          ),
                        );
                      } else if (controller.hasMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return null;
                    },
                    childCount:
                        controller.pokemons.length +
                        (controller.hasMore ? 1 : 0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
