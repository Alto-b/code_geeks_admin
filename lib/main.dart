
import 'package:code_geeks_admin/application/add_language_bloc/language_bloc.dart';
import 'package:code_geeks_admin/application/get_feedback_blc/get_feedback_bloc.dart';
import 'package:code_geeks_admin/application/get_language_bloc/get_language_bloc.dart';
import 'package:code_geeks_admin/application/get_mentor_bloc/get_mentor_bloc.dart';
import 'package:code_geeks_admin/application/get_subscription_bloc/get_subscription_bloc.dart';
import 'package:code_geeks_admin/application/mentor_bloc/mentor_bloc.dart';
import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/application/stats_bloc/stats_bloc.dart';
import 'package:code_geeks_admin/application/subs_page_blocs/subs_image_picker_bloc/subs_image_picker_bloc.dart';
import 'package:code_geeks_admin/application/subs_page_blocs/subs_language_bloc/subs_language_bloc.dart';
import 'package:code_geeks_admin/application/subscripttion_bloc/subscription_bloc.dart';
import 'package:code_geeks_admin/infrastructure/feedback_repo.dart';
import 'package:code_geeks_admin/infrastructure/language_repo.dart';
import 'package:code_geeks_admin/infrastructure/mentor_repo.dart';
import 'package:code_geeks_admin/infrastructure/subscription_repo.dart';
import 'package:code_geeks_admin/infrastructure/user_repo.dart';
import 'package:code_geeks_admin/presentation/login/login.dart';
import 'package:code_geeks_admin/presentation/splash%20screen/splash_screen.dart';
import 'package:code_geeks_admin/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker_web/image_picker_web.dart';

const SAVE_KEY_NAME ="UserLoggedIn";
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC6lX-_LJBYd8u_iDGm4auwfgIyqWL2vao",
          authDomain: "code-geeks-ff98c.firebaseapp.com",
          projectId: "code-geeks-ff98c",
          storageBucket: "code-geeks-ff98c.appspot.com",
          messagingSenderId: "688360665265",
          appId: "1:688360665265:web:4fb56584265a394951f290",
          measurementId: "G-3XJ49XKKVJ"
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(
          create: (context) => SidebarBloc(),
    
        ),
         BlocProvider(
          create: (context) => SubsLanguageBloc(LanguageRepo()),
    
        ),
         BlocProvider(
          create: (context) => SubsImagePickerBloc(),
    
        ),
         BlocProvider(
          create: (context) => SubscriptionBloc(),
    
        ),
        BlocProvider(
          create: (context) => LanguageBloc(),
    
        ),
        BlocProvider(
          create: (context) => GetLanguageBloc(LanguageRepo()),
    
        ),
        BlocProvider(
          create: (context) => GetMentorBloc(MentorRepo()),
    
        ),
        BlocProvider(
          create: (context) => GetSubscriptionBloc(SubscriptionRepo()),
    
        ),
            BlocProvider(
                create: (context) => MentorBloc(),
            ),
            BlocProvider(
                create: (context) => StatsBloc(LanguageRepo(),MentorRepo(),SubscriptionRepo(),UserRepo()),
            ),
            BlocProvider(
                create: (context) => GetFeedbackBloc(FeedbackRepo()),
            ),
        ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
              title: 'Code Geeks-Admin',
              theme: ThemeData(
              ),
              home:  SplashScreen()
            ),
    );
  }
}
