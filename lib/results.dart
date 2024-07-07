import 'package:rick_and_morty/episode.dart';
import 'package:rick_and_morty/location.dart';
import 'package:rick_and_morty/origin.dart';

class Results {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Origin origin;
  Location locationList;
  String image;
  List<Episode> episodeUrlList;
  String characterLineUrl;
  String characterCreatedDate;

  Results(
      this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.locationList,
      this.image,
      this.episodeUrlList,
      this.characterLineUrl,
      this.characterCreatedDate);
}
