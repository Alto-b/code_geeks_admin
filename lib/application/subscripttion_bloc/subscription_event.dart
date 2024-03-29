part of 'subscription_bloc.dart';

 class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionInitialEvent extends SubscriptionEvent{}

// class LanguageLoadEvent extends SubscriptionEvent{}

// class ImageUpdatedEvent extends SubscriptionEvent{}

class AddSubscriptionEvent extends SubscriptionEvent{
  Map<String,dynamic> data = {};
  String subId;
  AddSubscriptionEvent({
    required this.data,
    required this.subId
  });
}

class EditSubscriptionEvent extends SubscriptionEvent{
  Map<String,dynamic> data = {};
  String subId;
  EditSubscriptionEvent({
    required this.data,
    required this.subId
  });
}

class DeleteSubscriptionEvent extends SubscriptionEvent{
  String subId;
  DeleteSubscriptionEvent({
    required this.subId
  });
}