import 'package:code_geeks_admin/main.dart';
import 'package:code_geeks_admin/presentation/login/login.dart';
import 'package:code_geeks_admin/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    proceedToDashBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Image.asset('lib/assets/logo.png'),
      ),
    );
  }

  Future<void> proceedToDashBoard()async{
     final _sharedprefs = await SharedPreferences.getInstance();
   final  _userLoggedIn=_sharedprefs.getBool(SAVE_KEY_NAME);
  if(_userLoggedIn==null || _userLoggedIn==false){
    await Future.delayed(Duration(seconds: 3));
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LoginPage()));
  }
  else{
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>SidebarPage()));
  }
  }
}