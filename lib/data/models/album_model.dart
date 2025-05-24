import '../../domain/entities/album_entity.dart';

class AlbumModel {
  final int id;
  final String title;
  final String thumbnailUrl;

  AlbumModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '', // May be injected later
    );
  }

  AlbumEntity toEntity() {
    return AlbumEntity(
      id: id,
      title: title,
      thumbnailUrl: thumbnailUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
