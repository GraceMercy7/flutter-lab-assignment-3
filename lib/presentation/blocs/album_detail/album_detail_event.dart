import 'package:equatable/equatable.dart';

abstract class AlbumDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAlbumDetail extends AlbumDetailEvent {
  final int albumId;

  FetchAlbumDetail(this.albumId);

  @override
  List<Object?> get props => [albumId];
}
