part of 'image_bloc.dart';

abstract class ImageEvent  {
  const ImageEvent();
}

class UploadImage extends ImageEvent{
  var imgpath;

  UploadImage(this.imgpath);
}
class RemoveImage extends ImageEvent{

}
class UpdateImage extends ImageEvent{

}