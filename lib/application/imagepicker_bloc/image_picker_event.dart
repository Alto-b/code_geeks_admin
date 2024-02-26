part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

// class ImageUpdateEvent extends ImagePickerEvent{
//   final Uint8List file;

//   ImageUpdateEvent({required this.file});

// }

class GalleryPick extends ImagePickerEvent{}