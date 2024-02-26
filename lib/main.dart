import 'package:code_geeks_admin/application/imagepicker_bloc/image_picker_bloc.dart';
import 'package:code_geeks_admin/application/language_bloc/language_bloc.dart';
import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
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
          create: (context) => LanguageBloc(),
    
        ),
            BlocProvider(
                create: (context) => ImagePickerBloc(ImagePickerWeb()),
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
