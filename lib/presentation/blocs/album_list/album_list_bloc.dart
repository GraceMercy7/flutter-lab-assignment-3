import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_list_event.dart';
import 'album_list_state.dart';
import '../../../domain/usecases/fetch_albums_usecase.dart';

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final FetchAlbumsUseCase fetchAlbumsUseCase;

  AlbumListBloc(this.fetchAlbumsUseCase) : super(AlbumListInitial()) {
    on<LoadAlbumsEvent>((event, emit) async {
      emit(AlbumListLoading());
      try {
        final albums = await fetchAlbumsUseCase.execute();
        emit(AlbumListLoaded(albums));
      } catch (e) {
        emit(AlbumListError('Failed to load albums'));
      }
    });
  }
}
