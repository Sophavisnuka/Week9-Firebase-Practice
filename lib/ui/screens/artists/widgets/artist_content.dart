import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_firebase/model/artists/artist.dart';
import 'package:week9_firebase/ui/screens/artists/view_model/artist_view_model.dart';
import 'package:week9_firebase/ui/screens/artists/widgets/artist_tile.dart';
import 'package:week9_firebase/ui/theme/theme.dart';
import 'package:week9_firebase/ui/utils/async_value.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({super.key});

  @override
  Widget build(BuildContext context) {

    ArtistViewModel artistVm = context.watch<ArtistViewModel>();

    AsyncValue<List<Artist>> asyncValue = artistVm.artistValue;

    List<Artist> artists = [];

    Widget content;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator(),);
      case AsyncValueState.error:
        content = Center(child: Text('error = ${asyncValue.error}', style: TextStyle(color: Colors.red),),);
      case AsyncValueState.success:
        artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) {
            final artist = artists[index];
            return ArtistTile(
              artist: artist,
            );
          },
        );
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artist", style: AppTextStyles.heading),
          SizedBox(height: 50),
          Expanded(
            child: content
          )
        ],
      ),
    );
  }
}