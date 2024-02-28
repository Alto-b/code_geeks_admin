import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:code_geeks_admin/infrastructure/language_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {

  SubscriptionBloc() : super(SubscriptionInitial()) {

    on<AddSubscriptionEvent>(addSubscriptionToFirebase);

  }

 
  FutureOr<void> addSubscriptionToFirebase(AddSubscriptionEvent event, Emitter<SubscriptionState> emit)async {
    try{
      await FirebaseFirestore.instance.collection("subscriptions")
      .doc()
      .set(event.data).then((value){
        debugPrint("addSubscription success");
      });
    }
    on FirebaseException catch(e){
      debugPrint("addSubs ${e.message}");
    }
  }


}
