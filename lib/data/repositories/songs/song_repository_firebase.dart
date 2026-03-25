import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week9_firebase/data/dtos/artist_dto.dart';
import 'package:week9_firebase/model/artists/artist.dart';
import 'package:week9_firebase/model/songs/song_with_artist.dart';
import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https('fir-flutter-48baa-default-rtdb.asia-southeast1.firebasedatabase.app', '/artist/songs.json');
  final Uri artistsUri = Uri.https('fir-flutter-48baa-default-rtdb.asia-southeast1.firebasedatabase.app', '/artist/artists.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      final decode = json.decode(response.body);

      if (decode == null) {
        return [];
      }

      final Map<String, dynamic> songsMap = Map<String, dynamic>.from(decode);

      final List<Song> songs = [];

      songsMap.forEach((key, value) {
        final songJson = Map<String, dynamic>.from(value as Map);
        songs.add(SongDto.fromJson(key, songJson));
      });

      return songs;

    } else {
      // 2- Throw exception if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<List<SongWithArtist>> fetchSongWithArtist() async {
    final List<Song> songs = await fetchSongs();
    final http.Response artistsResponse = await http.get(artistsUri);

    if (artistsResponse.statusCode != 200) {
      throw Exception('Failed to load artists');
    }

    final artistsDecoded = jsonDecode(artistsResponse.body);
    if (artistsDecoded == null) {
      return [];
    }

    final Map<String, dynamic> artistsMap = Map<String, dynamic>.from(artistsDecoded);
    final Map<String, Artist> artistCache = {};

    artistsMap.forEach((id, value) {
      final artistJson = Map<String, dynamic>.from(value as Map);
      artistCache[id] = ArtistDto.fromJson(id, artistJson);
    });

    final List<SongWithArtist> result = [];

    for (final song in songs) {
      final artist = artistCache[song.artist];
      if (artist != null) {
        result.add(SongWithArtist(
          song: song,
          artist: artist
          // songId: song.id,
          // title: song.title,
          // artistName: artist.artistName,
          // genre: artist.genre,
        ));
      }
    }

    return result;
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
