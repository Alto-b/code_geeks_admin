import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/domain/booking_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BookingsRepo{
  Future<List<BookingModel>> getBookings()async{
    List<BookingModel> bookingList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection("bookings").get();
      datas.docs.forEach((element) {
        final data = element.data();
        final booking = BookingModel(
          booking_amount: data['booking_amount'], 
          booking_id: data['booking_id'], 
          date: data['date'], 
          expiry: data['expiry'], 
          guide_id: data['guide_id'], 
          guide_name: data['guide_name'], 
          guide_photo: data['guide_photo'], 
          status: data['status'], 
          sub_id: data['sub_id'], 
          sub_lang: data['sub_lang'], 
          sub_photo: data['sub_photo'], 
          sub_title: data['sub_title'], 
          subscriptionDetails: data['subscriptionDetails'], 
          user_avatar: data['user_avatar'], 
          user_id: data['user_id'], 
          user_name: data['user_name']
          );
          bookingList.add(booking);
      });
      return bookingList;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting bookings. : ${e.message}");
    }
    return bookingList;
  }
}