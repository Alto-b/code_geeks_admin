import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:flutter/material.dart';

class LanguageRepo{

    Future<List<LanguageModel>> getlanguage()async{
      List<LanguageModel> langaugeList = [];
      try{
        final datas = await FirebaseFirestore.instance.collection('language').get();
        datas.docs.forEach((element) {
        final data = element.data();

        final lang = LanguageModel(
          langId: data['langId'],
          name: data['name'], 
          description: data['description'], 
          photo: data['photo']); 

          langaugeList.add(lang);
        });
        return langaugeList;        
      }
      on FirebaseException catch(e){
        debugPrint("expection getting lang. : ${e.message}");
      }
      return langaugeList;
    }
}