import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_firebase/data/repositories/artists/artist_repository_firebase.dart';
import 'package:week9_firebase/ui/screens/artists/view_model/artist_view_model.dart';
import 'package:week9_firebase/ui/screens/artists/widgets/artist_content.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistViewModel(
        artistRepository: ArtistRepositoryFirebase(),
      ),
      child: ArtistContent(),
    );
  }
}