import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/get_language_bloc/get_language_bloc.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:code_geeks_admin/infrastructure/language_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {

  SubscriptionBloc() : super(SubscriptionInitial()) {

    on<AddSubscriptionEvent>(addSubscriptionToFirebase);
    on<EditSubscriptionEvent>(editSubscription);
    on<DeleteSubscriptionEvent>(deleteSubscription);

  }

 
  FutureOr<void> addSubscriptionToFirebase(AddSubscriptionEvent event, Emitter<SubscriptionState> emit)async {
    try{
      await FirebaseFirestore.instance.collection("subscriptions")
      .doc(event.subId)
      .set(event.data).then((value){
        debugPrint("addSubscription success");
      });
      emit(SubscriptionInitial());
    }
    on FirebaseException catch(e){
      debugPrint("addSubs ${e.message}");
    }
  }



  FutureOr<void> editSubscription(EditSubscriptionEvent event, Emitter<SubscriptionState> emit)async{
    try{
      print(event.subId);
      await FirebaseFirestore.instance.collection("subscriptions")
      .doc(event.subId)
      .update(event.data).then((value){
        debugPrint("editSubscription success");
      });
    }
    on FirebaseException catch(e){
      debugPrint("editSubs ${e.message}"); 
    }
  }

  FutureOr<void> deleteSubscription(DeleteSubscriptionEvent event, Emitter<SubscriptionState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("subscriptions")
      .doc(event.subId)
      .delete();
    }
    on FirebaseException catch(e){
      print("deleteSubscription ${e.message}");
    }
  }
}
