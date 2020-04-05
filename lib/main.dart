import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/pokemon.dart';
import 'pokedatail.dart';
import 'dart:convert';



void main() => runApp(
    MaterialApp(
  title: "Poke App",
      //remove banner
      debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class HomePage extends StatefulWidget {

  @override
  HomePageState createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";


 PokeHub pokeHub;


  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon
            .map((poke) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                builder: (context) => PokeDatail(
                  pokemon: poke,
                )
              ));
            } ,
            child: Card(
              elevation: 3.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: poke.img,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(poke.img))),
                    ),
                  ),
                  Text(
                    poke.name,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ))
            .toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
