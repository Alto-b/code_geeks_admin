import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/domain/user_model.dart';
import 'package:flutter/material.dart';

class UserRepo{
  Future<List<UserModel>> getUsers()async{
    List<UserModel> userList = [];

    try{
      final datas = await FirebaseFirestore.instance.collection("users").get();
      datas.docs.forEach((element) {
          final data = element.data();
          final user = UserModel(
            id: data['id'], 
            name: data['Name'], 
            email: data['Email'], 
            profession: data['Profession'], 
            profile: data['profile']);

            userList.add(user);
      });
      return userList;
    }
    on FirebaseException catch(e){
      debugPrint("exception getting user  : ${e.message}");
    }
    return userList;
  }
}