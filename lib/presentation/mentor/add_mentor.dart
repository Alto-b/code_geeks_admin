import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/mentor_bloc/mentor_bloc.dart';
import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/presentation/mentor/widget/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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

  //  Uint8List? imageFile;
  //  File? newFile;
  // bool imageAvailable = false;
  Uint8List? newImage;

  DateTime? dob;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("Add new mentors",style: GoogleFonts.orbitron(
        fontSize: 20,fontWeight: FontWeight.w600 , color: Colors.grey
      ),),
      actions: [TextButton(onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: 2));
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
                        BlocBuilder<MentorBloc, MentorState>(
                          builder: (context, state) {
                             if(state is ImageUpdateState){
                              newImage = state.imageFile;
                              return GestureDetector(
                                onTap: () {
                                  
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

                              return IconButton(onPressed:(){
                                context.read<MentorBloc>().add(ImageUpdateEvent());
                              } , icon:Icon(Icons.add_a_photo));
                            
                           
                          },
                        ),
                        //Textfield(controller: controller, label: label, validator: (validateField(value))),
                        const SizedBox(height: 20,),
                        // textfield(controller: _nameController,label: "name",validator :validateField(_emailController.text)),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validateField,
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Name",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        const SizedBox(height: 20,),
                        // textfield(controller: _contactController,label: "contact"),
                         TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validateNumber,
                            controller: _contactController,
                            decoration: InputDecoration(
                              labelText: "Contact",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        const SizedBox(height: 20,),
                        // textfield(controller: _emailController,label: "email"),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validateEmail,        
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        const SizedBox(height: 20,),
                        // textfield(controller: _qualificationController,label: "qualification"),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validateField,
                            controller: _qualificationController,
                            decoration: InputDecoration(
                              labelText: "Qualification",
                              border: const OutlineInputBorder(),
                            ),
                          ),
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
                            selectedGender = newValue;
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
                            ElevatedButton(onPressed: (){
                                                          print(1);
                                                          addMentor(context);
                                                          print(2);
                                                          },style: ButtonStyle(
                                                          backgroundColor: MaterialStatePropertyAll(Colors.green[500])
                                                        ), child: const Text("Register",style: TextStyle(color: Colors.white),))
                              
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

  void addMentor(BuildContext context)async{
    if(newImage == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image cannot be empty"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(dob == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("DOB cannot be empty"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(_formKey.currentState!.validate() && newImage != null && dob != null){
  // print(1);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("language${_nameController.text.trim()}");
  // print(2);
  firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
  // print(3);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading data"),backgroundColor: Colors.amber,duration: Duration(seconds: 5),));

  await uploadTask;
  // print(4);
    var downloadUrl = await ref.getDownloadURL();
    // print("image link $downloadUrl");
    String mentorId = FirebaseFirestore.instance.collection("mentors").doc().id;

      Map<String,String> data = {
        "mentorId" : mentorId,
        "photo" : downloadUrl,
        "name" : _nameController.text.trim(),
        "contact" : _contactController.text.trim(),
        "email" : _emailController.text.trim(),
        "password" : "${_emailController.text.trim()}123",
        "qualification" : _qualificationController.text.trim(),
        "gender" : selectedGender ?? "not specified",
        "dob" : DateFormat('dd-MM-yyyy').format(dob!)
      };
      print(data);
    context.read<MentorBloc>().add(AddMentorEvent(data: data,mentorId: mentorId));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mentor registration successful"),backgroundColor: Colors.green,));
    BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: 0));
    }
    else{
      print("form not validated");
    }
  }

  //to validate email
String? validateEmail(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; 
}

  //to select dob
 Future<void> _selectDob(BuildContext context) async {
    //print("dob clicked");
  DateTime selectedDate = DateTime.now(); // Initialize with the current date.

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900), 
    lastDate: DateTime(2023), 
  );

  if (picked != null && picked != selectedDate) {
    dob = picked;
    String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
    _dobController.text = formattedDate.toString();
    print(picked);
  }
}

  //to validate not empty
String? validateField(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}

//to validate number
String? validateNumber(String? value) {
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Mobile number is required';
  }

  final RegExp numberRegExp = RegExp(r'^[0-9]{10}$');

  if (!numberRegExp.hasMatch(trimmedValue)) {
    return 'Mobile number must be exactly 10 digits and contain only numbers';
  }

  return null;
}
}
