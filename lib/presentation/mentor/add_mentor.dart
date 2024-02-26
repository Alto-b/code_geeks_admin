import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/imagepicker_bloc/image_picker_bloc.dart';
import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/presentation/mentor/widget/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;

class AddMentorPage extends StatelessWidget {
   AddMentorPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();

  String? selectedGender;
  final List<String> genderOptions = ['Male','Female','Not Specified'];

   Uint8List? imageFile;
   File? newFile;
  bool imageAvailable = false;

  DateTime? dob;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text("mentor"),
      actions: [TextButton(onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: 0+2));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => MentorListPage(),));
      }, child: const Text("Mentor list"))],),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: screenWidth/3,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        BlocBuilder<ImagePickerBloc, ImagePickerState>(
                          builder: (context, state) {
                             return GestureDetector(
                                                  onTap: ()async {
                                                  context.read<ImagePickerBloc>().add(GalleryPick());
                                                  newFile = state.file as File?;
                                                  print("newFile : ${newFile}");
                                                  },
                                                  child:  CircleAvatar(
                                                    radius: 50,
                                                    child:   Icon(Icons.add_a_photo),
                                                    backgroundImage:(state.file!=null)? MemoryImage(state.file!):null,
                                                   
                                                    
                                                  ),
                                                );
                            
                           
                          },
                        ),
                        const SizedBox(height: 20,),
                        textfield(controller: _nameController,label: "name"),
                        const SizedBox(height: 20,),
                        textfield(controller: _contactController,label: "contact"),
                        const SizedBox(height: 20,),
                        textfield(controller: _emailController,label: "email"),
                        const SizedBox(height: 20,),
                        textfield(controller: _qualificationController,label: "qualification"),
                        const SizedBox(height: 20,),
                        DropdownButtonFormField(
                          validator: (value) {
                            if(value==null){
                              return "select a gender";
                            }
                            return null;
                          },
                          value: selectedGender,
                          items: genderOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender));
                          }).toList(), 
                          onChanged: (String? newValue){

                          },
                          decoration: const InputDecoration(
                            hintText: "Gender"
                          ),),
                          const SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text("Date of birth : $"),
                            SizedBox(
                              width: 200,
                              child: TextFormField(controller: _dobController,readOnly: true,decoration: const InputDecoration(label: Text("Date of birth"),border: OutlineInputBorder()),)),
                            IconButton(onPressed: (){_selectDob(context);}, icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                        const SizedBox(height: 20,),
                        // textfield(controller: _genderController,label: "gender"),

                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(onPressed: (){
                              _nameController.clear();_contactController.clear();_dobController.clear();_emailController.clear();_genderController.clear();
                            },style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.red[500])
                            ), child: const Text("Clear",style: TextStyle(color: Colors.white),)),
                            const SizedBox(width: 20,),
                            BlocBuilder<ImagePickerBloc,ImagePickerState>(
                              builder: (context, state) {
                                return ElevatedButton(onPressed: (){
                                                          print(1);
                                                          addMentor(state.file!);
                                                          print(2);
                                                          },style: ButtonStyle(
                                                          backgroundColor: MaterialStatePropertyAll(Colors.green[500])
                                                        ), child: const Text("Register",style: TextStyle(color: Colors.white),));
                              },
                            ),
                          ],
                        )
                                      
                      ],
                                      ),
                    )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //to select dob
 Future<void> _selectDob(BuildContext context) async {
    //print("dob clicked");
  DateTime selectedDate = DateTime.now(); // Initialize with the current date.

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900), // Start date for selection
    lastDate: DateTime(2023), // End date for selection
  );

  if (picked != null && picked != selectedDate) {
    dob = picked;
    // _dobController.text = picked as String;
    print(picked);
    // Update the selected date
    // setState(() {
    //   selectedDate = picked;
    //   _dobController.text = selectedDate.toLocal().toString().split(' ')[0];
    // });
  }
}

Future<void> addMentor(Uint8List newFile)async{
  
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("profilepic${FirebaseAuth.instance.currentUser!.uid}");
    firebasestorage.UploadTask uploadTask = ref.putFile(newFile as File);

    await uploadTask;
    var downloadUrl = await ref.getDownloadURL();
    print("image link $downloadUrl");
  Map<String,String> data = {
    "profile" : downloadUrl,
    "name" : _nameController.text,
    "contact" : _contactController.text,
    "email" : _emailController.text,
    "qualification" : _qualificationController.text,
    "gender" : selectedGender??"not specified",
    "dob" : dob.toString()
  };
  print("started");
  await FirebaseFirestore.instance.collection('mentors').doc().set(data)
  .onError((error, _) => print("error is $error"));
  print("over");
}
}
