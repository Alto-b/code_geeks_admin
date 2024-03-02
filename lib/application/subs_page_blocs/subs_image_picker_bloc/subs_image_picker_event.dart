part of 'subs_image_picker_bloc.dart';

 class SubsImagePickerEvent extends Equatable {
  const SubsImagePickerEvent();

  @override
  List<Object> get props => [];
}
 
class ImagePickerInitial extends SubsImagePickerEvent{}

class ImageUpdateEvent extends SubsImagePickerEvent{}