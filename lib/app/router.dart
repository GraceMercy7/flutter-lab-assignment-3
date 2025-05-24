import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/album_list_page.dart';
import '../presentation/pages/album_detail_page.dart';
import '../domain/entities/album_entity.dart';
import '../data/repositories/album_repository.dart';

// Fetch albums using the updated AlbumRepository which uses http internally
Future<List<AlbumEntity>> fetchAlbums() async {
  final repository = AlbumRepository();
  final albumModels = await repository.fetchAlbumsWithThumbnails();
  return albumModels.map((model) => model.toEntity()).toList();
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder<List<AlbumEntity>>(
          future: fetchAlbums(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              );
            }
            final albums = snapshot.data ?? [];
            return AlbumListPage(albums: albums);
          },
        );
      },
      routes: [
        GoRoute(
          path: 'album/:id',
          builder: (BuildContext context, GoRouterState state) {
            final albumId = int.tryParse(state.pathParameters['id'] ?? '');
            if (albumId == null) {
              return const Scaffold(
                body: Center(child: Text('Invalid album ID')),
              );
            }
            return AlbumDetailPage(albumId: albumId);
          },
        ),
      ],
    ),
  ],
);