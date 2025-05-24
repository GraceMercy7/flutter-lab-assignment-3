import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/album_entity.dart';
import '../widgets/album_card.dart';

class AlbumListPage extends StatelessWidget {
  final List<AlbumEntity> albums;
  final bool isLoading;
  final String? errorMessage;

  const AlbumListPage({
    Key? key,
    required this.albums,
    this.isLoading = false,
    this.errorMessage,
  }) : super(key: key);

  String sanitizeTitle(String title) {
    return title.replaceAll(RegExp(r'[^\x00-\x7F]'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Photo Albums',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : errorMessage != null
          ? Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.white),
        ),
      )
          : Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                itemCount: albums.length,
                shrinkWrap: true, // Allows the ListView to be scrollable
                physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: _HoverableAlbumCard(
                      album: AlbumEntity(
                        id: album.id,
                        title: sanitizeTitle(album.title),
                        thumbnailUrl: album.thumbnailUrl,
                      ),
                      onTap: () => context.push('/album/${album.id}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HoverableAlbumCard extends StatefulWidget {
  final AlbumEntity album;
  final VoidCallback onTap;

  const _HoverableAlbumCard({
    Key? key,
    required this.album,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_HoverableAlbumCard> createState() => _HoverableAlbumCardState();
}

class _HoverableAlbumCardState extends State<_HoverableAlbumCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double scale = _isHovered ? 1.03 : 1.0;
    final List<BoxShadow>? shadow = _isHovered
        ? [
      BoxShadow(
        color: Colors.white24,
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(0, 2),
      )
    ]
        : null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(scale),
          decoration: BoxDecoration(
            boxShadow: shadow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AlbumCard(album: widget.album),
        ),
      ),
    );
  }
}