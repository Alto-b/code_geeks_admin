import 'dart:io';
import 'dart:typed_data';

import 'package:code_geeks_admin/application/add_language_bloc/language_bloc.dart';
import 'package:code_geeks_admin/application/get_language_bloc/get_language_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLanguagePage extends StatelessWidget {
   AddLanguagePage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _languageNameController = TextEditingController();
  final _languageDescriptionController = TextEditingController();

  // Uint8List? imageFile;
  Uint8List? newImage;
 
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    context.read<GetLanguageBloc>().add(LanguageLoadEvent());
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Manage Language"),centerTitle: true,),

      body: SingleChildScrollView(
        child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      width: (screenWidth/2)-300,
                      height: (screenHeight/2)+300,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: _formKey,
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
                                    radius: 60,
                                    child: Icon(Icons.add),
                                  ),
                                );
                                }
                                else if (state is ImageUpdateState){
                                  newImage = state.imageFile;
                       //////////////////////////////////////////////////////////////////////           
                                  // Uint8List imageBytes = state.imageFile; // Assuming state.imageFile is a Uint8List
                                  //   String tempPath = Directory.systemTemp.path;
                                  //   File imageFile = File('$tempPath/image.jpg'); // Provide a file path with the desired file name and extension

                                    // Write the bytes to the file
                                    //  imageFile.writeAsBytes(imageBytes);

                                  // print("newImage ${newImage!.length}");
                                  return GestureDetector(
                                  onTap: () {
                                    context.read<LanguageBloc>().add(ImageUpdateEvent());
                                    // print("emit recieved ${state.imageFile}");
                                  },
                                  child: Container(
                                    height: 150,width: 150,
                                    child: ClipRRect( 
                                      borderRadius: BorderRadius.circular(20),
                                      clipBehavior: Clip.antiAlias,
                                      // radius: 60,
                                      // child: Icon(Icons.abc),
                                      // backgroundImage: MemoryImage(state.imageFile),
                                      child: Image.memory(state.imageFile,filterQuality: FilterQuality.high,fit: BoxFit.fill)
                                      ),
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
                              controller: _languageNameController,
                              validator: validateField,
                              decoration: const InputDecoration(
                                label: Text("Language"),
                                border: OutlineInputBorder()
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: _languageDescriptionController,
                              validator: validateField,
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
                                newImage = null;
                                _languageNameController.clear();
                                _languageDescriptionController.clear();
                              },),
                              const SizedBox(width: 20,),
                             ActionChip(
                              backgroundColor: Colors.green,
                              side: BorderSide.none,
                              elevation: 5,
                              avatar: const Icon(Icons.add,color: Colors.white,),
                              label: const Text("Add",style: TextStyle(color: Colors.white),),onPressed: () {
                              uploadLanguage(context);
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
                        child: BlocBuilder<GetLanguageBloc, GetLanguageState>(
                          builder: (context, state) {
                            print("a ${state.runtimeType}");
                            if(state is LanguageLoadedState){
                              return ListView.builder(
                                                  itemBuilder: (BuildContext context,int index){
                                                    return ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: NetworkImage(state.languageList[index].photo),
                                                        // child: Image.network(state.languageList[index].photo),
                                                      ),
                                                      title: Text(state.languageList[index].name),
                                                      onTap: () {
                                                        
                                                      },
                                                    );
                                                  }, 
                                                  // separatorBuilder: (BuildContext context,int index)=>Divider(), 
                                                  itemCount: state.languageList.length);
                            }
                            return Text("No languages registered");
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
      )
    );
  }

  //to validate not empty
String? validateField(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}



  void uploadLanguage(BuildContext context)async{
    if(newImage == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image cannot be empty"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(_formKey.currentState!.validate() && newImage != null){
  //     print("newImage ${newImage!.length}"); 
  //     print("langauge ${_languageNameController.text.trim()}");
  //     print("description ${_languageDescriptionController.text.trim()}");
  // print(1);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("language${_languageNameController.text.trim()}");
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,));
  // print(2);
  firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
  // print(3);
 
  await uploadTask;
  // print(4);
    var downloadUrl = await ref.getDownloadURL();
    // print("image link $downloadUrl");

      Map<String,String> data = {
        "photo" : downloadUrl,
        "name" : _languageNameController.text.trim(),
        "description" : _languageDescriptionController.text.trim()
      };
      
      context.read<LanguageBloc>().add(AddLanguageEvent(data: data));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Uploaded !"),backgroundColor: Colors.green,));
      _languageNameController.clear();_languageDescriptionController.clear();
      // context.read<LanguageBloc>().add(());
    }
    else{
      print("form not validated");
    }
 
  }
}