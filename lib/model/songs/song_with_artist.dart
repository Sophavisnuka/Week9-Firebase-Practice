import 'package:week9_firebase/model/artists/artist.dart';
import 'package:week9_firebase/model/songs/song.dart';

class SongWithArtist {
  final Song song;
  final Artist artist;

  SongWithArtist({
    required this.song,
    required this.artist
  });

}