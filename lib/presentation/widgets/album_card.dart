import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/album_entity.dart';

class AlbumCard extends StatelessWidget {
  final AlbumEntity album;

  const AlbumCard({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          album.thumbnailUrl, // Display album thumbnail from API
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.image_not_supported),
        ),
        title: Text(
          album.title, // Display album title from API (English text)
        ),
        onTap: () {
          // Navigate to album detail page with album ID
          context.go('/album/${album.id}');
        },
      ),
    );
  }
}
