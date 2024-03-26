import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/domain/feedback_model.dart';
import 'package:flutter/material.dart';

class FeedbackRepo{
  
  Future<List<FeedbackModel>> getFeedback()async{
    List<FeedbackModel> feedbackList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection("Feedbacks").get();
      datas.docs.forEach((element) {
          final data = element.data();
          final feedback = FeedbackModel(
            email: data['Email'], 
            feedback: data['Feedback']
            );
            feedbackList.add(feedback);
      });
    }
    on FirebaseException catch(e){
      debugPrint("exception while loading feedbacks ${e.message}");
    }
    return feedbackList;
  }

}