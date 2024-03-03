part of 'get_subscription_bloc.dart';

 class GetSubscriptionState extends Equatable {
  const GetSubscriptionState();
  
  @override
  List<Object> get props => [];
}

final class GetSubscriptionInitial extends GetSubscriptionState {}

class GetSubscriptionLoadedState extends GetSubscriptionState{
  final List<SubscriptionModel> subscriptionList;
  GetSubscriptionLoadedState({
    required this.subscriptionList
  });
}