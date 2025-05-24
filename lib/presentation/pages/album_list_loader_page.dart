import 'package:flutter/material.dart';
import '../../data/repositories/album_repository.dart';
import '../../domain/entities/album_entity.dart';
import 'album_list_page.dart';

class AlbumListLoaderPage extends StatefulWidget {
  const AlbumListLoaderPage({Key? key}) : super(key: key);

  @override
  State<AlbumListLoaderPage> createState() => _AlbumListLoaderPageState();
}

class _AlbumListLoaderPageState extends State<AlbumListLoaderPage> {
  late Future<List<AlbumEntity>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    final repository = AlbumRepository();
    _albumsFuture = repository.fetchAlbumsWithThumbnails().then(
          (models) => models.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumEntity>>(
      future: _albumsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final albums = snapshot.data ?? [];
        return AlbumListPage(albums: albums);
      },
    );
  }
}
