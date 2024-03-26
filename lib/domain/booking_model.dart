class BookingModel{
  String booking_amount;
  String booking_id;
  String date;
  String expiry;
  String guide_id;
  String guide_name;
  String guide_photo;
  String status;
  String sub_id;
  String sub_lang;
  String sub_photo;
  String sub_title;
  String user_avatar;
  String user_id;
  String user_name;
  Map<String,dynamic> subscriptionDetails;

  BookingModel({
    required this.booking_amount,
    required this.booking_id,
    required this.date,
    required this.expiry,
    required this.guide_id,
    required this.guide_name,
    required this.guide_photo,
    required this.status,
    required this.sub_id,
    required this.sub_lang,
    required this.sub_photo,
    required this.sub_title,
    required this.subscriptionDetails,
    required this.user_avatar,
    required this.user_id,
    required this.user_name
  });
}