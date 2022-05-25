// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, unused_field, prefer_final_fields, unnecessary_new

import 'package:flutter/material.dart';
import 'package:pokeball_widget/pokeball_widget.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/providers/database.dart';
import 'package:pokedex/screens/pokemon_details.dart';
import 'package:pokedex/widgets/loading_poke_ball.dart';
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

  //Searching info
  String _searchTerm;
  bool userTextSearch = false;
  TextEditingController userSearch = TextEditingController();
  FocusNode _focusUserSearch = new FocusNode();
  List<Pokemon> foundPokemon = [];

  void closingUserSearch() {
    userSearch.text = "";
    setState(() {
      foundPokemon = pokemons;
      _focusUserSearch.unfocus();
      userTextSearch = false;
    });
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      pokemons = await DatabaseMethods().getAllPokemon();
      foundPokemon = pokemons;

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Pokemon> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = pokemons;
    } else {
      results = pokemons
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundPokemon = results;
    });
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
                          PokeBallLoading(),
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
                child: SingleChildScrollView(
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

                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: TextField(
                            onChanged: (val) {
                              _runFilter(val.trim());
                              setState(() {
                                userTextSearch = true;
                              });
                            },
                            controller: userSearch,
                            focusNode: _focusUserSearch,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Pokemon',
                              hintStyle: TextStyle(color: Colors.black),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5,
                                ),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: PokeBallWidget(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              suffixIcon: userTextSearch
                                  ? GestureDetector(
                                      onTap: () {
                                        closingUserSearch();
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.black,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),

                      //List View Container for Pokemons
                      Container(
                        height: userTextSearch
                            ? screenHeight - 250
                            : screenHeight - 160,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: foundPokemon.length,
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
                                      pageBuilder: (_, __, ___) =>
                                          PokemonDetails(
                                        pokemon: foundPokemon[i],
                                      ),
                                    ),
                                  );
                                },
                                child: PokeCard(
                                  image: foundPokemon[i].image,
                                  name: foundPokemon[i].name,
                                  number: foundPokemon[i].number,
                                  type: foundPokemon[i].type,
                                  color: foundPokemon[i].color,
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
            ),
    );
  }
}
