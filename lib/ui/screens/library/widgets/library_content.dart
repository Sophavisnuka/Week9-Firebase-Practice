import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song_with_artist.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<SongWithArtist>> asyncValue = mv.songsValue;

    Widget content;
    switch (asyncValue.state) {

      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(child: Text('error = ${asyncValue.error!}', style: TextStyle(color: Colors.red),));


      case AsyncValueState.success:
        List<SongWithArtist> songs = asyncValue.data!;

        if (songs.isEmpty) {
          content = Center(
            child: Text('No songs available', style: TextStyle(color: Colors.grey)),
          );
        } else {
          content = ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final songWithArtist = songs[index];
              final song = mv.getSongById(songWithArtist.songId);

              // Skip if song not found - log it for debugging
              if (song == null) {
                return SizedBox.shrink();
              }

              return SongTile(
                song: song,
                artistName: songWithArtist.artistName,
                genre: songWithArtist.genre,
                isPlaying: mv.isSongPlaying(song),
                onTap: () {
                  mv.start(song);
                },
              );
            },
          );
        }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
