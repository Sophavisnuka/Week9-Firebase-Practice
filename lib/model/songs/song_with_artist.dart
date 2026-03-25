import 'package:week9_firebase/model/artists/artist.dart';
import 'package:week9_firebase/model/songs/song.dart';

class SongWithArtist {
  // final String songId;
  // final String title;
  // final String artistName;
  // final String genre;
  final Song song;
  final Artist artist;

  SongWithArtist({
    required this.song,
    required this.artist
    // required this.songId,
    // required this.title,
    // required this.artistName,
    // required this.genre,
  });

}