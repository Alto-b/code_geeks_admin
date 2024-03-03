import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_admin/application/subscripttion_bloc/subscription_bloc.dart';
import 'package:code_geeks_admin/domain/subscription_model.dart';
import 'package:code_geeks_admin/infrastructure/subscription_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_subscription_event.dart';
part 'get_subscription_state.dart';

class GetSubscriptionBloc extends Bloc<GetSubscriptionEvent, GetSubscriptionState> {
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  GetSubscriptionBloc(this.subscriptionRepo) : super(GetSubscriptionInitial()) {
    on<GetSubscriptionLoadEvent>(getSubscription);
  }

  FutureOr<void> getSubscription(GetSubscriptionLoadEvent event, Emitter<GetSubscriptionState> emit)async {
    emit(GetSubscriptionInitial());
    final subs = await subscriptionRepo.getSubscriptions();
    if(subs.isEmpty){
      emit(GetSubscriptionInitial());
    }
    emit(GetSubscriptionLoadedState(subscriptionList: subs));
  }
}
