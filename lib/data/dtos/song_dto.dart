import '../../model/songs/song.dart';

class SongDto {
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String artistKey = 'artistsId';
  static const String durationKey = 'duration';
  static const String imageUrl = 'imageUrl';

  static Song fromJson(String id, Map<String, dynamic> json) {
    // assert(json[artistKey] is String);
    assert(json[titleKey] is String);
    assert(json[durationKey] is int);
    assert(json[imageUrl] is String);

    return Song(
      id: id,
      artist: id,
      title: json[titleKey],
      duration: Duration(milliseconds: json[durationKey]),
      imageUrl: Uri.parse(json[imageUrl]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      idKey: song.id,
      titleKey: song.title,
      artistKey: song.artist,
      durationKey: song.duration.inMilliseconds,
      imageUrl: song.imageUrl.toString(),
    };
  }
}
