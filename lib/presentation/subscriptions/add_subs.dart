// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/application/subs_page_blocs/subs_image_picker_bloc/subs_image_picker_bloc.dart';
import 'package:code_geeks_admin/application/subs_page_blocs/subs_language_bloc/subs_language_bloc.dart';
import 'package:code_geeks_admin/application/subscripttion_bloc/subscription_bloc.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionPage extends StatelessWidget {
   SubscriptionPage({super.key});

  final _key = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  final lang = ["General"];

  List<LanguageModel> langList =[];

  String? selectedLang;

  Uint8List? newImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    context.read<SubsLanguageBloc>().add(LanguageLoadEvents());
    context.read<SubsImagePickerBloc>().add(ImageUpdateEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Subscription Package"),
        centerTitle: true,
        ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                // height: screenHeight,
                width: screenWidth/3,
                // decoration: BoxDecoration(
                //   border: Border.all()
                // ),
                child: Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          validator: validateNotEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 20,),

                        BlocBuilder<SubsLanguageBloc, SubsLanguageState>(
                          builder: (context, state) {
                            print(state.runtimeType);

                            if(state is LanguageLoadedStates){
                              langList.clear();
                            langList.addAll(state.languageList);
                              return  DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                    hintText: "Select Language",
                                                    border: OutlineInputBorder()
                                                  ),
                                                  items: langList.map((value) {
                                                    return DropdownMenuItem(child: Text(value.name),value: value,);
                                                  }).toList() , 
                                                  onChanged: (value) {
                                                    selectedLang = value!.name;
                                                    print(selectedLang);
                                                  },);
                            }
                             return  DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                    hintText: "Select Language",
                                                    border: OutlineInputBorder()
                                                  ),
                                                  items: lang.map((value) {
                                                    return DropdownMenuItem(child: Text(value),value: value,);
                                                  }).toList() , 
                                                  onChanged: (value) {
                                                    selectedLang = value as String;
                                                  },);
                          },
                        ),
                          const SizedBox(height: 20,),

                        TextFormField(
                          controller: _descriptionController,
                          validator: validateNotEmpty,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder()
                          ),
                        ),const SizedBox(height: 20,),

                        BlocBuilder<SubsImagePickerBloc, SubsImagePickerState>(
                          builder: (context, state) {
                            print(state.runtimeType);
                            if(state is ImageUpdateState){
                              return GestureDetector(
                                onTap: () {
                                   context.read<SubsImagePickerBloc>().add(ImageUpdateEvent());
                                   newImage = state.imageFile;
                                   print(newImage!.length);
                                },
                                child: Container(
                                  height: 150,width: 300,
                                  child: Image.memory(state.imageFile,fit: BoxFit.cover,),
                                ),
                              );
                            }
                            return IconButton(onPressed: (){
                              context.read<SubsImagePickerBloc>().add(ImageUpdateEvent());
                            }, icon: const Icon(Icons.add_a_photo));
                          },
                        ),
                      
                        const SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          uploadSubscription(context);
                        }, child: const Text("Add Package"))
                      ],
                    ),
                  )),
              )
            ],
          ),
        ),
      ),
    );
  }

  //to upload subscriptions
  void  uploadSubscription(BuildContext context)async{
    if(newImage == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image cannot be empty"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(_key.currentState!.validate() && newImage != null){
  //     print("newImage ${newImage!.length}"); 
  //     print("title ${_titleController.text.trim()}");
  //     print("description ${_descriptionController.text.trim()}");
  //     print("lang ${selectedLang}");
  // print(1);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("subs_${_titleController.text.trim()}");
  // print(2);
  firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
  // print(3);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,));
  await uploadTask;
  // print(4);
    var downloadUrl = await ref.getDownloadURL();
    // print("image link $downloadUrl");

      Map<String,String> data = {
        "photo" : downloadUrl,
        "language" : selectedLang!,
        "title" : _titleController.text.trim(),
        "description" : _descriptionController.text.trim()
      };
      context.read<SubscriptionBloc>().add(AddSubscriptionEvent(data: data));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Subscription added successfully !"),backgroundColor: Colors.green,));
      BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: 0));
    }
    else{
      debugPrint("form not validated");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something unexpected happened!"),backgroundColor: Colors.red,));

    }
  }

  //to validate not empty
String? validateNotEmpty(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}
}