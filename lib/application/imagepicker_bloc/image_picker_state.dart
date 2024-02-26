part of 'image_picker_bloc.dart';

class ImagePickerState extends Equatable {

ImagePickerState([this.file]);
  
   Uint8List? file;


ImagePickerState  copyWith(Uint8List? file){
  return ImagePickerState(file ?? this.file);
}

  
  @override
  List<Object?> get props => [file];
}

// final class ImagePickerInitial extends ImagePickerState {}

// class ImageUpdateState extends ImagePickerState {
//   final Uint8List file;

//   ImageUpdateState({
//     required this.file
//   });

//   @override
//   List<Object> get props => [file];
 
// }
