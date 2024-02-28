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
  Map<String,String> data = {};
  AddSubscriptionEvent({
    required this.data
  });
}