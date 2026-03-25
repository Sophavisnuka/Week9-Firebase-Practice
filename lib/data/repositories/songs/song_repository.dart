import 'package:week9_firebase/model/songs/song_with_artist.dart';

import '../../../model/songs/song.dart';

abstract class SongRepository {
  Future<List<Song>> fetchSongs();
  
  Future<Song?> fetchSongById(String id);

  Future<List<SongWithArtist>> fetchSongWithArtist();
}
