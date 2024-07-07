import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/episode.dart';
import 'package:rick_and_morty/location.dart';
import 'package:rick_and_morty/origin.dart';
import 'package:rick_and_morty/results.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Results> allResults = [];

  final String _baseUrl = "https://rickandmortyapi.com/api/character";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _jsonCozumle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView.builder(
      itemCount: allResults.length,
      itemBuilder: _karakterOgesiniOlustur,
    );
  }

  Widget? _karakterOgesiniOlustur(BuildContext context, int index) {
    return ListTile(
      title: Text(allResults[index].name),
      subtitle: Text(allResults[index].species),
      leading: Image.network(
        allResults[index].image,
        width: 100,
        height: 100,
      ),
    );
  }

  void _jsonCozumle() async {
    Uri uri = Uri.parse(_baseUrl);
    http.Response response = await  http.get(uri);
    Map<String, dynamic> resultsMap = jsonDecode(response.body);

    //String jsonString = await rootBundle.loadString("assets/rickandmorty.json");
    //Map<String, dynamic> resultsMap = json.decode(jsonString);

    List<dynamic> resultList = resultsMap["results"];

    for (Map<String, dynamic> characterMap in resultList) {
      int characterId = characterMap["id"] ?? -1;
      String characterName = characterMap["name"] ?? "";
      String characterStatus = characterMap["status"] ?? "";
      String characterSpecies = characterMap["species"] ?? "";
      String characterType = characterMap["type"] ?? "";
      String characterGender = characterMap["gender"] ?? "";

      Map<String, dynamic> charactersOriginMap = characterMap["origin"] ?? {};
      String originName = charactersOriginMap["name"] ?? "";
      String originUrl = charactersOriginMap["url"] ?? "";
      Origin origin = Origin(originName, originUrl);

      Map<String, dynamic> locationMap = characterMap["location"] ?? {};
      String locationName = locationMap["name"] ?? "";
      String locationUrl = locationMap["url"] ?? "";
      Location location = Location(locationName, locationUrl);

      List<dynamic> episodeMap = characterMap["episode"] ?? {};

      List<Episode> allEpisodesMaps = [];

      String characterImage = characterMap["image"] ?? "";

      for (String episode in episodeMap) {
        Episode episodes = Episode(episode);
        allEpisodesMaps.add(episodes);
      }
      String characterUrl = characterMap["url"] ?? "";
      String characterCreatedDate = characterMap["created"] ?? "";

      Results character = Results(
          characterId,
          characterName,
          characterStatus,
          characterSpecies,
          characterType,
          characterGender,
          origin,
          location,
          characterImage,
          allEpisodesMaps,
          characterUrl,
          characterCreatedDate);
      allResults.add(character);
    }
    setState(() {});
  }
}
