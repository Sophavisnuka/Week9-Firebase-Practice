import 'package:flutter/material.dart';
import 'package:week9_firebase/model/songs/song_with_artist.dart';
import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.songWithArtist
    // this.artistName,
    // this.genre,
  });

  final Song song;
  final SongWithArtist songWithArtist;
  final bool isPlaying;
  final VoidCallback onTap;
  // final String? artistName;
  // final String? genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(song.title),
          subtitle: Text('${song.duration.inMinutes} min     ${songWithArtist.artist.artistName} - ${songWithArtist.artist.genre}'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(song.imageUrl.toString()),
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
