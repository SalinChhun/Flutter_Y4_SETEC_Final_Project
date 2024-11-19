part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();
}

class ImageInitial extends ImageState {
  @override
  List<Object> get props => [];
}
class ImageUploading extends ImageState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ImageUpCompleted extends ImageState{
  Imageresponse? imageResponse;


  ImageUpCompleted(this.imageResponse);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ImageUpError extends ImageState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}