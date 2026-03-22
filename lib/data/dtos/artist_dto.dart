import 'package:week9_firebase/model/artists/artist.dart';

class ArtistDto {
  static const String artistId = 'artistId';
  static const String artistName = 'name';
  static const String genre = 'genre';
  static const String artistProfile = 'imageUrl';

  static Artist fromJson(String id, Map<String, dynamic>json) {
    return Artist(
      artistName: json[artistName], 
      genre: json[genre], 
      artistProfile: Uri.parse(json[artistProfile]),
    );
  }

  Map<String, dynamic> toJson(Artist artist) {
    return {
      artistId: artistId,
      artistName: artistName,
      genre: genre,
      artistProfile: artistProfile.toString(),
    };
  }
}