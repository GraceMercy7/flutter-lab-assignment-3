import 'package:equatable/equatable.dart';
import '../../../data/models/photo_model.dart';
import '../../../data/models/album_model.dart';

abstract class AlbumDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumDetailInitial extends AlbumDetailState {}

class AlbumDetailLoading extends AlbumDetailState {}

class AlbumDetailLoaded extends AlbumDetailState {
  final AlbumModel album;
  final List<PhotoModel> photos;

  AlbumDetailLoaded({required this.album, required this.photos});

  @override
  List<Object?> get props => [album, photos];
}

class AlbumDetailError extends AlbumDetailState {
  final String message;

  AlbumDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
