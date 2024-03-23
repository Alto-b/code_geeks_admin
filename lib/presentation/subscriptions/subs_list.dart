
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/get_subscription_bloc/get_subscription_bloc.dart';
import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/application/subs_page_blocs/subs_image_picker_bloc/subs_image_picker_bloc.dart';
import 'package:code_geeks_admin/application/subs_page_blocs/subs_language_bloc/subs_language_bloc.dart';
import 'package:code_geeks_admin/application/subscripttion_bloc/subscription_bloc.dart';
import 'package:code_geeks_admin/domain/language_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubListTable extends StatelessWidget {
   SubListTable({
    super.key,
  });

  final _key = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _amountController = TextEditingController();

  String? subId;

  final lang = ["General"];

  List<LanguageModel> langList =[];

  String? selectedLang;
  String? LangImg;
  String? LangDesc;

  Uint8List? newImage;

  @override
  Widget build(BuildContext context) {
    context.read<GetSubscriptionBloc>().add(GetSubscriptionLoadEvent());
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<GetSubscriptionBloc, GetSubscriptionState>(
      builder: (context, state) {
        if(state is GetSubscriptionLoadedState){
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)
              ),
              child: DataTable(
              headingRowHeight: 50,
              headingRowColor:MaterialStatePropertyAll(Colors.grey[400]),
              dataRowHeight: 80,
                 columns: const [
                   DataColumn(label: Text('Sl.No')),
                   DataColumn(label: Text('Title')),
                   DataColumn(label: Text('Description')),
                   DataColumn(label: Text('Language')),
                   DataColumn(label: Text('Amount')),
                   DataColumn(label: Text('Action')),
                  //  DataColumn(label: Text('')),
                 ],
                 rows: [
                   for (int i = 0; i < state.subscriptionList.length; i++)
                     DataRow(cells: [
                       DataCell(Text("${i+1}")),
                       DataCell(Text(state.subscriptionList[i].title)),
                       // DataCell(Text(state.mentorList[i].name)),
                       DataCell(Text("${state.subscriptionList[i].descritpion}",overflow: TextOverflow.ellipsis,)),
                       DataCell(Text(state.subscriptionList[i].language)),
                       DataCell(Text(state.subscriptionList[i].amount)),
                       DataCell(Row(
                         children: [
                           IconButton(onPressed: () {
                            showEditBox(context,state,i);
                           }, icon: const Icon(Icons.edit_outlined)),
                           IconButton(onPressed: () {
                            deleteDialog(context, state.subscriptionList[i].subsId);
                           }, icon: const Icon(Icons.delete_outline))
                         ],
                       )),
                      //  DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline))),
                     ]),
                 ],
               ),
            ),
          );
           
        }
      else if(state is GetSubscriptionInitial){
        return Text("Loading...");
      }
      return Text("Add subcsription to be listed.");
      },
    );
  }

  Future<void>  deleteDialog(BuildContext context,String id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete subscription?'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This subscription will be removed and cannot be revoked.'),
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
              context.read<SubscriptionBloc>().add(DeleteSubscriptionEvent(subId: id));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removing Subscription..."),backgroundColor: Colors.blue,));
              Future.delayed(Duration(seconds: 3)).then((value){
                 Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Subscription removed"),backgroundColor: Colors.blue,));
              });
             
            },
          ),
        ],
      );
    },
  );
}
  
  Future<void> showEditBox(BuildContext context,GetSubscriptionLoadedState state,int i){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    _titleController.text = state.subscriptionList[i].title;
    selectedLang = state.subscriptionList[i].language;
    _descriptionController.text = state.subscriptionList[i].descritpion;
    _amountController.text = state.subscriptionList[i].amount;
    String oldImage = state.subscriptionList[i].photo;
    return showDialog(context: context, 
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Subscription'),
        content: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                // height: screenHeight,
                width: screenWidth/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                                      LangImg = value.photo;
                                                      LangDesc = value.description;
                                                      
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
                          TextFormField(
                            controller: _amountController,
                            validator: validateNotEmpty,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder()
                            ),
                          ),
                          SizedBox(height: 20,),
                  
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
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: MemoryImage(state.imageFile),
                                  )
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  context.read<SubsImagePickerBloc>().add(ImageUpdateEvent());
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                      backgroundImage: NetworkImage(oldImage),
                                    ),
                              );
                            },
                          ),
                        
                          const SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){
                            editSubscription(context, state.subscriptionList[i].subsId);
                          }, child: const Text("Edit Package"))
                        ],
                      ),
                    )),
                ),
              ),
            //   SizedBox(height: 20,),
            //  SubListTable()
            ],
          ),
        ),
      ),
      );
    },
    );
  }

  Future<void> editSubscription(BuildContext context,String id) async {
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
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,duration: Duration(seconds: 5),));
  await uploadTask;
  // print(4);
    var downloadUrl = await ref.getDownloadURL();
    // print("image link $downloadUrl");
    // subId = FirebaseFirestore.instance.collection("subscriptions").doc().id;

      Map<String,String> data = {
        "SubsId" :id ,
        "photo" : downloadUrl,
        "language" : selectedLang!,
        "LangImg" : LangImg!,
        "LangDesc" : LangDesc!,
        "title" : _titleController.text.trim(),
        "description" : _descriptionController.text.trim(), 
        "amount" : _amountController.text.trim()
      };
      context.read<SubscriptionBloc>().add(EditSubscriptionEvent(data: data,subId: id));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Subscription added successfully !"),backgroundColor: Colors.green,));
      
      // BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: 0));
      Navigator.pop(context);
      _titleController.clear();_descriptionController.clear();_amountController.clear();
      context.read<SubsImagePickerBloc>().add(ImagePickerInitial());
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

