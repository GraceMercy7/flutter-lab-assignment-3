import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/album_model.dart';
import '../../../data/models/photo_model.dart';
import '../../../data/repositories/album_repository.dart';
import 'album_detail_event.dart';
import 'album_detail_state.dart';

class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final AlbumRepository repository;

  AlbumDetailBloc(this.repository) : super(AlbumDetailInitial()) {
    on<FetchAlbumDetail>((event, emit) async {
      emit(AlbumDetailLoading());
      try {
        final albums = await repository.getAlbums();
        final photos = await repository.getPhotos();

        final album = albums.firstWhere((a) => a.id == event.albumId);
        final albumPhotos = photos.where((p) => p.albumId == event.albumId).toList();

        emit(AlbumDetailLoaded(album: album, photos: albumPhotos));
      } catch (e) {
        emit(AlbumDetailError('Failed to fetch album details'));
      }
    });
  }
}
