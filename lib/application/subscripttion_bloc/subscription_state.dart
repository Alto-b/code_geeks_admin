part of 'subscription_bloc.dart';

 class SubscriptionState extends Equatable {
  const SubscriptionState();
  
  @override
  List<Object> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

// class LanguageLoadedState extends SubscriptionState{
//   final List<LanguageModel> languageList;
//   LanguageLoadedState({required this.languageList});
// }

// class ImageUpdatedState extends SubscriptionState{
//   final Uint8List imageFile;
//   ImageUpdatedState({required this.imageFile});

//   @override
//   List<Object> get props => [imageFile];
// }

//loading all contents
// class SubsPageLoadedState extends SubscriptionState {
//   final List<LanguageModel> languageList;
//   final Uint8List imageFile;
//   // final List<MentorModel> mentorList;

//   SubsPageLoadedState({
//     required this.languageList,
//     required this.imageFile
//   });
// }