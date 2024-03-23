import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'mentor_event.dart';
part 'mentor_state.dart';

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  MentorBloc() : super(MentorInitial()) {

    on<ImageUpdateEvent>(imageUpdate);
    on<AddMentorEvent>(addMentorToFirebase);
    on<EditMentorEvent>(editMentor);
    on<DeleteMentorEvent>(deleteMentor);
    
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

  // FutureOr<void> addMentorToFirebase(AddMentorEvent event, Emitter<MentorState> emit)async{
  //   try{
  //     String uid = event.data['mentorId']!;
  //     String name = event.data['name']!;
  //     String email = event.data['email']!;
  //     String password = event.data['password']!;
  //     await FirebaseFirestore.instance.collection("mentors")
  //     .doc(event.mentorId)
  //     .set(event.data).then((value){
  //       print("addMentor successful");
  //     }).then((value)async{
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: email, 
  //         password: password);
  //     })
  //     // .then((value)async{
  //     //   await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
  //     // });
  //     .whenComplete(()async{
  //       await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
  //       // await FirebaseAuth.instance.currentUser!.;
  //     });
  //   }
  //   on FirebaseException catch(e){
  //     print("addMentor : ${e.message}");
  //   }
  // }

  Future<void> addMentorToFirebase(AddMentorEvent event, Emitter<MentorState> emit) async {
  try {
    String uid = event.data['mentorId']!;
    String name = event.data['name']!;
    String email = event.data['email']!;
    String password = event.data['password']!;
    
    

    // Create user in Firebase Authentication
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).whenComplete(()async{
      await FirebaseFirestore.instance.collection("mentors").doc(FirebaseAuth.instance.currentUser!.uid).set(event.data);
    }).whenComplete(() async{
      await FirebaseFirestore.instance.collection("mentors")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .update({
      'mentorId' : FirebaseAuth.instance.currentUser!.uid
    });
    });

    // Add mentor details to Firestore with the specified mentorId
    // await FirebaseFirestore.instance.collection("mentors").doc(FirebaseAuth.instance.currentUser!.uid).set(event.data);
    
    // await FirebaseFirestore.instance.collection("mentors")
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .update({
    //   'mentorId' : FirebaseAuth.instance.currentUser!.uid
    // });

    // Update display name for the current user
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

    print("addMentor successful");
  } catch (e) {
    if (e is FirebaseException) {
      print("addMentor Error: ${e.message}");
    } else {
      print("addMentor Error: $e");
    }
  }
}


  FutureOr<void> editMentor(EditMentorEvent event, Emitter<MentorState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("mentors")
      .doc(event.mentorId)
      .update(event.data).then((value){
        print("editMentor Successful");
      });
    }
    on FirebaseException catch(e){
      print("editMentor : ${e.message}");
    }
  }



  FutureOr<void> deleteMentor(DeleteMentorEvent event, Emitter<MentorState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("mentors")
      .doc(event.mentorId)
      .delete();
    }
    on FirebaseException catch(e){
      print("deleteMentor : ${e.message}");
    }
  }
}
