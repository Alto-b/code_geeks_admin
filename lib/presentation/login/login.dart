import 'package:code_geeks_admin/main.dart';
import 'package:code_geeks_admin/presentation/splash%20screen/splash_screen.dart';
import 'package:code_geeks_admin/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        
        body: Center(
          child: Container(
            width: screenWidth/2+50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            //parent box
            child: Card(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 0, 0, 0),
              borderOnForeground: true,
              color: const Color.fromARGB(209, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //left box
                    SizedBox(
                      height: screenHeight/1.5,
                      width: screenWidth/4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight/6,),
                                  Text("Welcome back",style:GoogleFonts.orbit(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black54,),),
                                  const SizedBox(height: 10,),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter your email id",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                      ),
                                      prefixIcon: Icon(Icons.person_2_outlined,color: Colors.grey,size: 15,)
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                      ),
                                      prefixIcon: Icon(Icons.lock,color: Colors.grey,size: 15,)
                                    ),
                                  ),
                                  const SizedBox(height: 30,),

                                  ActionChip.elevated(
                                    backgroundColor: Colors.blue[400],
                                    elevation: 5,
                                    label:  Text("Login",style: GoogleFonts.orbit(color: Colors.white,fontSize: 10),),
                                    onPressed: () {
                                    loginIn(context);
                                  },),

                                ],
                              )),
                          )
                        ],
                      ),
                    ),
                    //right box
                    Container(
                      height: screenHeight/1.5,
                      width: screenWidth/4,
                    
                      decoration:  BoxDecoration(
                        border: Border.all(color: Colors.white,width: 0),
                        color: const Color.fromARGB(194, 110, 132, 214),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Image.asset('lib/assets/logo.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  void loginIn(BuildContext context)async{
    if(_emailController.text.trim()=="admin@gmail.com" && _passwordController.text.trim() == "admin"){
      final _sharedPrefs= await SharedPreferences.getInstance();
   await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome admin"),backgroundColor: Colors.green,));
      // await Future.delayed(Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false);
    }
    else if(_emailController.text.trim() =="" && _passwordController.text.trim() == ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Credentials cannot be empty"),backgroundColor: Colors.red,));
    }
    else if(_emailController.text.trim()!="admin@gmail.com" && _passwordController.text.trim() != "admin"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Check your credenials"),backgroundColor: Colors.red,));
    }
    
  }

  
}