import 'package:flutter/material.dart';
import 'package:pokedex/paginas/pokemon_info/pokemon_info.dart';

void main() {
  runApp(const PokemonList());
}

class PokemonFotoNome {
  static final List<Pokemon> pokemons = [
    const Pokemon(
      name: 'bulbasaur',
      imageUrl: 'assets/images/pokemon1.png',
      color: Colors.green,
      tipo: ['Grass', 'Poison'],
      peso: 6.9,
      altura: 0.7,
      number: '#001',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [108 / 300, 200 / 300, 64 / 300, 104 / 300, 195 / 1000],
    ),
    const Pokemon(
      name: 'ivysaur',
      imageUrl: 'assets/images/pokemon2.png',
      color: Color.fromARGB(255, 4, 84, 101),
      tipo: ['Grass', 'Poison'],
      peso: 13.0,
      altura: 1.0,
      number: '#002',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [148 / 300, 220 / 300, 74 / 300, 200 / 300, 275 / 500],
    ),
    const Pokemon(
      name: 'venosaur',
      imageUrl: 'assets/images/pokemon3.png',
      color: Color.fromARGB(255, 3, 90, 80),
      tipo: ['Grass', 'Poison'],
      peso: 100.0,
      altura: 2.0,
      number: '#003',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [176 / 300, 235 / 300, 44 / 300, 206 / 300, 199 / 1000],
    ),
    const Pokemon(
      name: 'charmander',
      imageUrl: 'assets/images/pokemon4.png',
      color: Color.fromARGB(255, 249, 195, 76),
      tipo: ['Fire', 'Fire'],
      peso: 13.0,
      altura: 1.0,
      number: '#004',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [156 / 300, 215 / 300, 85 / 300, 218 / 300, 305 / 1000],
    ),
    const Pokemon(
      name: 'charmeleon',
      imageUrl: 'assets/images/pokemon5.png',
      color: Color.fromARGB(255, 223, 54, 7),
      tipo: ['Fire', 'Fire'],
      peso: 13.0,
      altura: 1.0,
      number: '#005',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [156 / 300, 215 / 300, 85 / 300, 218 / 300, 305 / 1000],
    ),
    const Pokemon(
      name: 'charizard',
      imageUrl: 'assets/images/pokemon6.png',
      color: Color.fromARGB(255, 236, 109, 50),
      tipo: ['Flying', 'Fire'],
      peso: 13.0,
      altura: 1.0,
      number: '#006',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [168 / 300, 205 / 300, 64 / 300, 204 / 300, 295 / 1000],
    ),
    const Pokemon(
      name: 'squirtle',
      imageUrl: 'assets/images/pokemon7.png',
      color: Color.fromARGB(
        255,
        114,
        211,
        230,
      ),
      tipo: ['Water', 'Water'],
      peso: 13.0,
      altura: 1.0,
      number: '#007',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [170 / 300, 222 / 300, 72 / 300, 230 / 300, 255 / 1000],
    ),
    const Pokemon(
      name: 'wartortle',
      imageUrl: 'assets/images/pokemon8.png',
      color: Color.fromARGB(255, 129, 113, 154),
      tipo: ['Water', 'Water'],
      peso: 13.0,
      altura: 1.0,
      number: '#008',
      status: ["HP  ", "ATK", "DEF", "SPD", "EXP"],
      statusNumber: [168 / 300, 258 / 300, 78 / 300, 212 / 300, 282 / 1000],
    ),
  ];
}

class Pokemon {
  final String name;
  final String imageUrl;
  final Color color;
  final List<String> tipo;
  final double peso;
  final double altura;
  final String number;
  final List<String> status;
  final List<double> statusNumber;

  const Pokemon({
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.tipo,
    required this.peso,
    required this.altura,
    required this.number,
    required this.status,
    required this.statusNumber,
  });
}

class PokemonList extends StatelessWidget {
  const PokemonList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Pokedex';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            'Pokedex',
          ),
        ),
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: PokemonFotoNome
                .pokemons.length, //vai retorna numeros de itens na lista
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (BuildContext context, int index) { 
              Pokemon pokemon = PokemonFotoNome.pokemons[index]; 
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonInfo(pokemon: pokemon),
                    ),
                  );
                },
                child: GridTile(
                  footer: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: GridTileBar(
                      title: Center(
                        child: Text(
                          pokemon.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: pokemon.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 50),
                    child: Image.asset(
                      pokemon.imageUrl,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
