import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/paginas/pokemon_list/pokemon_list.dart';

class PokemonInfo extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfo({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> statusColor = [
      const Color(0xFFB71C1C),
      Colors.amber,
      Colors.blue,
      const Color.fromARGB(255, 164, 182, 225),
      const Color(0xFF1B5E20),
    ];
    final List<Widget> statusWidgets = []; // inicializada como uma lista vazia 
    for (int i = 0; i < pokemon.status.length; i++) {
      statusWidgets.add( // armazenando uma coluna vertical criada pelo for 
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 10, 0),
          child: SizedBox(
            height: 20,
            child: LinearPercentIndicator(
              backgroundColor: Colors.white,
              progressColor: statusColor[i],
              percent: pokemon.statusNumber[i],
              width: 320,
              lineHeight: 14,
              barRadius: const Radius.circular(20),
              center: Text(
                pokemon.statusNumber[i].toStringAsFixed(2),
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 0, 0, 0),),
              ),
              leading: Text(
                pokemon.status[i],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: pokemon.color,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Row(
            children: [
              const Text(
                'Pokedex',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                pokemon.number,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: pokemon.color,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Image.asset(
                pokemon.imageUrl,
                width: 400,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 50,
                child: Text(
                  pokemon.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 164, 182, 225),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          pokemon.tipo[0],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            height: 1.3,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          pokemon.tipo[1],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.3,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 20,
                      child: Text(
                        pokemon.peso.toString() + " KG",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pokemon.altura.toString() + "  M",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Text(
                      '   Weight',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Text(
                      'Height',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Base Stats',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: statusWidgets, //criando uma coluna vertical de informações de status do Pokémon
            ),
          ],
        ),
      ),
    );
  }
}
