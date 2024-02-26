import 'dart:io';

import 'package:code_geeks_admin/application/language_bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLanguagePage extends StatelessWidget {
   AddLanguagePage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _languageNameController = TextEditingController();
  final _languageDescriptionController = TextEditingController();

  File? imageFile;
 
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Manage Language"),centerTitle: true,),

      body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: (screenWidth/2)-300,
                    height: (screenHeight/2)+200,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        child: Column(
                        children: [
                          const SizedBox(height: 20),
                          
                          BlocBuilder<LanguageBloc, LanguageState>(
                            builder: (context, state) {
                              print(state.runtimeType);
                              if(state is LanguageInitial){
                                 return GestureDetector(
                                onTap: () {
                                   context.read<LanguageBloc>().add(ImageUpdateEvent());
                                  // print("emit recieved ${state.}");
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.add),
                                ),
                              );
                              }
                              else if (state is ImageUpdateState){
                                return GestureDetector(
                                onTap: () {
                                  context.read<LanguageBloc>().add(ImageUpdateEvent());
                                  print("emit recieved ${state.imageFile}");
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.abc),
                                  // backgroundImage: Image.file(file),
                                  ),

                              );
                              }
                              else{
                                return Text("error");
                              }
                              
                              }
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Language"),
                              border: OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            maxLines: 7,
                            decoration: const InputDecoration(
                              label: Text("Description"),
                              border: OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            ActionChip(
                              backgroundColor: Colors.red,
                              side: BorderSide.none,
                              elevation: 5,
                              avatar: const Icon(Icons.cancel,color: Colors.white,),
                              label: const Text("Clear",style: TextStyle(color: Colors.white),),onPressed: () {
                              
                            },),
                            const SizedBox(width: 20,),
                           ActionChip(
                            backgroundColor: Colors.green,
                            side: BorderSide.none,
                            elevation: 5,
                            avatar: const Icon(Icons.add,color: Colors.white,),
                            label: const Text("Add",style: TextStyle(color: Colors.white),),onPressed: () {
                            
                          },)
                            ],
                          )
                          
                        ],
                      )),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.blue,
                    width: (screenWidth/2)-300,
                    height: (screenHeight/2)+200,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                            title: Text("language ${index+1}"),
                            onTap: () {
                              
                            },
                          );
                        }, 
                        // separatorBuilder: (BuildContext context,int index)=>Divider(), 
                        itemCount: 25),
                    ),
                  )
                ],
              ),
            )
    );
  }
}