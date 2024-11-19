import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/Image/ImageResponse.dart';
import '../repository/Image/Imagerepository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageRepository imageRepository = ImageRepository();
  ImageBloc() : super(ImageInitial()) {
    on<UploadImage>((event, emit) async  {
      // TODO: implement event handler
      try{
        emit(ImageUploading());
        var res = await imageRepository.UploadImage(imagepath: event.imgpath);
        emit(ImageUpCompleted(res));

      }catch(err){
        emit(ImageUpError());
      }
    });
  }
}
