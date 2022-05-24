// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

//Model
import '../models/pokemon.dart';

class DatabaseMethods {
  //Find all Pokemons
  Future<List<Pokemon>> getAllPokemon() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151');
    List<Pokemon> pokemons = [];

    try {
      final response = await http.get(
        url,
      );

      final extractedData = json.decode(response.body);
      var pokemonsPre = extractedData['results'];

      for (var i = 0; i < pokemonsPre.length; i++) {
        var pokeurl = Uri.parse(pokemonsPre[i]['url']);

        //Getting the specific pokemon data
        var responePoke = await http.get(pokeurl);
        var extractedPoke = json.decode(responePoke.body);

        int id = extractedPoke['id'];

        //Getting the Description
        var descriptionURL =
            Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id');

        var descriptionResponse = await http.get(descriptionURL);

        var extractedDescription = json.decode(descriptionResponse.body);

        var description =
            extractedDescription['flavor_text_entries'][0]['flavor_text'];
        var color = extractedDescription['color']['name'];

        pokemons.add(
          Pokemon(
            name: extractedPoke['name'],
            number: extractedPoke['id'],
            image: extractedPoke['sprites']['front_default'],
            type: extractedPoke['types'][0]['type']['name'],
            description: description,
            color: color,
          ),
        );
        print('Amount of loaded Pokemons: ${i + 1}');
      }
    } catch (e) {
      print('Error on fetching all Pokemons: $e');
    }
    return pokemons;
  }
}
