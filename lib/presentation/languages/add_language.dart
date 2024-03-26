import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/add_language_bloc/language_bloc.dart';
import 'package:code_geeks_admin/application/get_language_bloc/get_language_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class AddLanguagePage extends StatelessWidget {
   AddLanguagePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _upformKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        title: const Text("Add/Manage Language"),
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 20,fontWeight: FontWeight.w600 , color: Colors.grey
        ),
        centerTitle: true,),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all()
                    ),
                  width: (screenWidth/2)-300,
                  // height: (screenHeight/2)+300,
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
                              return GestureDetector(
                              onTap: () {
                                context.read<LanguageBloc>().add(ImageUpdateEvent());
                              },
                              child: Container(
                                height: 150,width: 150,
                                child: ClipRRect( 
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAlias,
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
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
                ),
                // width: (screenWidth/2)-300,
                // height: (screenHeight/2)+200,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<GetLanguageBloc, GetLanguageState>(
                    builder: (context, state) {
                      print("a ${state.runtimeType}");
                      if(state is LanguageLoadedState){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)
              ),
              child: DataTable(
                headingRowColor:MaterialStatePropertyAll(Colors.grey[400]),
                dataRowHeight: 60,
                columns: const [
                  DataColumn(label: Text('Sl.No')),
                  // DataColumn(label: Text('')),
                  DataColumn(label: Text('Language')),
                  DataColumn(label: Text('Description')),
                  // DataColumn(label: Text('Status')),
                  // DataColumn(label: Text('Subscriptions')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: [
                  for (int i = 0; i < state.languageList.length; i++)
                    DataRow(cells: [
                      DataCell(Text("${i+1}")),
                      DataCell(Row(
                        children: [
                          CircleAvatar(backgroundImage:NetworkImage(state.languageList[i].photo) ,),
                          SizedBox(width: 10,),
                          Text(state.languageList[i].name)
                        ],
                      )),
                      // DataCell(Text(state.mentorList[i].name)),
                      DataCell(Text(state.languageList[i].description)),
                      // DataCell(Text("available")),
                      // DataCell(Text('')),
                      DataCell(IconButton(onPressed: () {
                        // showEditBox(context,state,i);
                        editLanguageBox(context, state, i);
                      }, icon: const Icon(Icons.edit_outlined))),
                      DataCell(IconButton(onPressed: () {
                        deleteDialog(context, state.languageList[i].langId);
                      }, icon: const Icon(Icons.delete_outline))),
                    ]),
                ],
              ),
            ),
          );
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
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("language${_languageNameController.text.trim()}");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,));
  firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
  await uploadTask;
    var downloadUrl = await ref.getDownloadURL();
    String langId = FirebaseFirestore.instance.collection("language").doc().id;

      Map<String,String> data = {
        "langId" : langId,
        "photo" : downloadUrl,
        "name" : _languageNameController.text.trim(),
        "description" : _languageDescriptionController.text.trim()
      };
      
      context.read<LanguageBloc>().add(AddLanguageEvent(data: data,langId: langId));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Uploaded !"),backgroundColor: Colors.green,));
      _languageNameController.clear();_languageDescriptionController.clear();
    }
    else{
      print("form not validated");
    }
 
  }

  void editLanguageBox(BuildContext context,LanguageLoadedState state,int i )async{
      String oldImage = state.languageList[i].photo;
      _languageNameController.text = state.languageList[i].name;
      _languageDescriptionController.text = state.languageList[i].description;

      return showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Edit Language'),
            content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()),
                // width: (screenWidth/2)-300,
                // height: (screenHeight/2)+300,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _upformKey,
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
                              backgroundImage: NetworkImage(oldImage),
                            ),
                          );
                          }
                          else if (state is ImageUpdateState){
                            newImage = state.imageFile;
                            return GestureDetector(
                            onTap: () {
                              context.read<LanguageBloc>().add(ImageUpdateEvent());
                              newImage = state.imageFile;
                            },
                            child: Container(
                              height: 150,width: 150,
                              child: ClipRRect( 
                                borderRadius: BorderRadius.circular(20),
                                clipBehavior: Clip.antiAlias,
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
                        label: const Text("Edit",style: TextStyle(color: Colors.white),),onPressed: () {
                        editLanguage(context,state.languageList[i].langId);
                      },)
                        ],
                      )
                      
                    ],
                  )),
                ),
              ),
          );
          
        }
        );
  }

  void editLanguage(BuildContext context,String id)async{
    if(newImage == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image cannot be empty"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(_upformKey.currentState!.validate() && newImage != null){
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("language${_languageNameController.text.trim()}");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,));
  firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
  await uploadTask;
    var downloadUrl = await ref.getDownloadURL();

      Map<String,String> data = {
        "langId" : id,
        "photo" : downloadUrl,
        "name" : _languageNameController.text.trim(),
        "description" : _languageDescriptionController.text.trim()
      };
      
      context.read<LanguageBloc>().add(EditLanguageEvent(data: data,langId: id));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Language edited !"),backgroundColor: Colors.green,));
      Navigator.pop(context);
      _languageNameController.clear();_languageDescriptionController.clear();
    }
    else{
      print("form not validated");
    }
 
  }

  Future<void>  deleteDialog(BuildContext context,String id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Language?'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This language will be removed and cannot be revoked.The subscriptions based on this language will be also affected.'),
              Text('Would you like to continue?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              context.read<LanguageBloc>().add(DeleteLangaugeEvent(langId: id));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removing Language and related subscriptions..."),backgroundColor: Colors.blue,));
              Future.delayed(Duration(seconds: 3)).then((value){
                 Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Language removed"),backgroundColor: Colors.blue,));
              });
             
            },
          ),
        ],
      );
    },
  );
}
}