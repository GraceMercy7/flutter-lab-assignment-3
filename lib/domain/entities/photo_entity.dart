class PhotoEntity {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoEntity({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
}
