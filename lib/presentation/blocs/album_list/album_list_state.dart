import '../../../data/models/album_model.dart';
abstract class AlbumListState {}

class AlbumListInitial extends AlbumListState {}

class AlbumListLoading extends AlbumListState {}

class AlbumListLoaded extends AlbumListState {
  final List<AlbumModel> albums;

  AlbumListLoaded(this.albums);
}

class AlbumListError extends AlbumListState {
  final String message;

  AlbumListError(this.message);
}
