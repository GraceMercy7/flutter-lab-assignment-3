import '../../data/repositories/album_repository.dart';
import '../../data/models/album_model.dart';

class FetchAlbumsUseCase {
  final AlbumRepository repository;

  FetchAlbumsUseCase(this.repository);

  Future<List<AlbumModel>> execute() async {
    return await repository.fetchAlbumsWithThumbnails();
  }
}
