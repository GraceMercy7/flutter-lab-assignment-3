import 'package:flutter/material.dart';
import '../../data/models/photo_model.dart';

class PhotoGrid extends StatelessWidget {
  final List<PhotoModel> photos;

  const PhotoGrid({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final photo = photos[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            photo.thumbnailUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, color: Colors.red);
            },
          ),
        );
      },
    );
  }
}
