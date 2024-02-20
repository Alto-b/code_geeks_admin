import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    Container(
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
}