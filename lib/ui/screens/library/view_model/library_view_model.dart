import 'package:flutter/material.dart';
import 'package:week9_firebase/data/repositories/artists/artist_repository.dart';
import 'package:week9_firebase/model/songs/song_with_artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository? artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songRepository, required this.playerState, this.artistRepository}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final songsWithArtist = await songRepository.fetchSongWithArtist();
      songsValue = AsyncValue.success(songsWithArtist);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
  
  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);

  void stop(Song song) => playerState.stop();
}
