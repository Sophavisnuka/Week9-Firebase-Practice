import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https('fir-flutter-48baa-default-rtdb.asia-southeast1.firebasedatabase.app', '/artist/songs.json');

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
  Future<Song?> fetchSongById(String id) async {}
}
