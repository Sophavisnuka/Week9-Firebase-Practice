import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week9_firebase/data/dtos/artist_dto.dart';
import 'package:week9_firebase/data/repositories/artists/artist_repository.dart';
import 'package:week9_firebase/model/artists/artist.dart';

class ArtistRepositoryFirebase extends ArtistRepository{
  final Uri artistUri = Uri.https('fir-flutter-48baa-default-rtdb.asia-southeast1.firebasedatabase.app', '/artist/artists.json');
  @override
  Future<List<Artist>> fetchArtist() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      final decode = json.decode(response.body);

      if (decode == null) {
        return [];
      }

      final Map<String, dynamic> artistMap = Map<String, dynamic>.from(decode);

      final List<Artist> artists = [];

      artistMap.forEach((key, value) {
        final artistJson = Map<String, dynamic>.from(value);
        artists.add(ArtistDto.fromJson(key, artistJson));
      });

      return artists;
    } else {
      throw Exception('Failed to load post');
    }
  } 
}