import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/domain/subscription_model.dart';
import 'package:flutter/material.dart';

class SubscriptionRepo{

  Future<List<SubscriptionModel>> getSubscriptions() async{

    List<SubscriptionModel> subscriptionList = [];

    try{
      final datas = await FirebaseFirestore.instance.collection("subscriptions").get();
      datas.docs.forEach((element) {
        final data = element.data();
        final subscription = SubscriptionModel(
          subsId: data['SubsId'],
          title: data['title'], 
          language: data['language'], 
          descritpion: data['description'], 
          photo: data['photo'], 
          amount: data['amount'],
          LangImg : data['LangImg'],
          LangDesc: data['LangDesc'],
          videos: data['videos']);

          subscriptionList.add(subscription);
      });
      return subscriptionList;
    }
   on FirebaseException catch(e){
      debugPrint("expection getting subscritpions. : ${e.message}");
    }
    return subscriptionList;
  }
}