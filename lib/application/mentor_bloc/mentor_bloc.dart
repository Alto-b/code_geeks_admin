import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'mentor_event.dart';
part 'mentor_state.dart';

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  MentorBloc() : super(MentorInitial()) {
    // on<MentorEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ImageUpdateEvent>(imageUpdate);
    on<AddMentorEvent>(addMentorToFirebase);
  }

  FutureOr<void> imageUpdate(ImageUpdateEvent event, Emitter<MentorState> emit)async{
    try{
      Uint8List? file = await ImagePickerWeb.getImageAsBytes();
      emit(ImageUpdateState(imageFile: file!));
    }
    catch(e){
      print("Exception occured while picking mentor image $e");
    }
  }

  FutureOr<void> addMentorToFirebase(AddMentorEvent event, Emitter<MentorState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("mentors")
      .doc()
      .set(event.data).then((value){
        print("addMentor successful");
      });
    }
    on FirebaseException catch(e){
      print("addMentor : ${e.message}");
    }
  }
}
