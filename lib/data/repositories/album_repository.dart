import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';
import '../models/photo_model.dart';
import '../../constants/api_constants.dart';

class AlbumRepository {
  Future<List<AlbumModel>> getAlbums() async {
    final response = await http.get(Uri.parse(ApiConstants.albumsUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => AlbumModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<PhotoModel>> getPhotos() async {
    final response = await http.get(Uri.parse(ApiConstants.photosUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<AlbumModel>> fetchAlbumsWithThumbnails() async {
    final albums = await getAlbums();
    final photos = await getPhotos();

    return albums.map((album) {
      final firstPhoto = photos.firstWhere(
            (photo) => photo.albumId == album.id,
        orElse: () => PhotoModel(
          id: 0,
          albumId: 0,
          title: '',
          url: '',
          thumbnailUrl: '',
        ),
      );

      return AlbumModel(
        id: album.id,
        title: album.title,
        thumbnailUrl: firstPhoto.thumbnailUrl,
      );
    }).toList();
  }
}
