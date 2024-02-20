import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/sidebar.dart';
import 'package:code_geeks_admin/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
            // BlocProvider(
            //     create: (context) => SubjectBloc(),
            // ),
        ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
              title: 'Code Geeks-Admin',
              theme: ThemeData(
              ),
              home:  SidebarPage()
            ),
    );
  }
}
