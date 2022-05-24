// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/database.dart';
import 'package:pokedex/screens/pokemon_details.dart';
import 'package:pokedex/widgets/poke_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> pokemons = [];
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      pokemons = await DatabaseMethods().getAllPokemon();

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _isLoading
          ? SafeArea(
              child: Container(
                child: Center(
                  child: Container(
                    height: 300,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red,
                          ),
                          Text(
                            "Please Wait... Pokemons Loading...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Center(
                            child: Text(
                              'Pokedex',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                    Container(
                      height: screenHeight - 100,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        shrinkWrap: true,
                        itemCount: pokemons.length,
                        itemBuilder: (context, i) =>
                            ChangeNotifierProvider.value(
                          value: pokemons[i],
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 2,
                            width: MediaQuery.of(context).size.width / 2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(seconds: 0),
                                    pageBuilder: (_, __, ___) => PokemonDetails(
                                      pokemon: pokemons[i],
                                    ),
                                  ),
                                );
                              },
                              child: PokeCard(
                                image: pokemons[i].image,
                                name: pokemons[i].name,
                                number: pokemons[i].number,
                                type: pokemons[i].type,
                                color: pokemons[i].color,
                              ),
                            ),
                          ),
                          // Text(
                          //   pokemons[i].name,
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
