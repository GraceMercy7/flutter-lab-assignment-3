import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/photo_entity.dart';
import '../../data/repositories/album_repository.dart';

class AlbumDetailPage extends StatefulWidget {
  final int albumId;

  const AlbumDetailPage({Key? key, required this.albumId}) : super(key: key);

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  late Future<List<PhotoEntity>> _photosFuture;

  @override
  void initState() {
    super.initState();
    final repository = AlbumRepository();

    _photosFuture = repository.getPhotos().then(
          (allPhotos) => allPhotos
          .where((p) => p.albumId == widget.albumId)
          .map((p) => PhotoEntity(
        id: p.id,
        albumId: p.albumId,
        title: p.title,
        url: p.url,
        thumbnailUrl: p.thumbnailUrl,
      ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Album ${widget.albumId}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'), // Navigate back to album list
          tooltip: 'Back',
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<List<PhotoEntity>>(
        future: _photosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final photos = snapshot.data ?? [];

          return Scrollbar(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final photo = photos[index];
                return _HoverablePhotoTile(photo: photo);
              },
            ),
          );
        },
      ),
    );
  }
}

class _HoverablePhotoTile extends StatefulWidget {
  final PhotoEntity photo;

  const _HoverablePhotoTile({Key? key, required this.photo}) : super(key: key);

  @override
  State<_HoverablePhotoTile> createState() => _HoverablePhotoTileState();
}

class _HoverablePhotoTileState extends State<_HoverablePhotoTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isHovered ? 1.05 : 1.0;
    final shadow = _isHovered
        ? [
      BoxShadow(
        color: Colors.white24,
        blurRadius: 10,
        spreadRadius: 1,
        offset: const Offset(0, 3),
      )
    ]
        : null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(scale),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: shadow,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.photo.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.photo.title,
              style: const TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}