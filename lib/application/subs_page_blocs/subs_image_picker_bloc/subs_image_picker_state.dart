part of 'subs_image_picker_bloc.dart';

 class SubsImagePickerState extends Equatable {
  const SubsImagePickerState();
  
  @override
  List<Object> get props => [];
}

final class SubsImagePickerInitial extends SubsImagePickerState {}
 
class ImageUpdateState extends SubsImagePickerState{
  final Uint8List imageFile;
  ImageUpdateState({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}