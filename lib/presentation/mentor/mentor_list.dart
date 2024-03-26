import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/get_mentor_bloc/get_mentor_bloc.dart';
import 'package:code_geeks_admin/application/mentor_bloc/mentor_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MentorListPage extends StatelessWidget {
  MentorListPage({super.key});

  final List<String> list = ['a', 'g', 'v', 'r','a', 'g', 'v', 'r','a', 'g', 'v', 'r','a', 'g', 'v', 'r'];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  Uint8List? newImage;
  String? selectedGender;
  DateTime? dob;
  final List<String> genderOptions = ['Male','Female','Not Specified'];



  @override
  Widget build(BuildContext context) {
    context.read<GetMentorBloc>().add(MentorLoadEvent());
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
  
    return  Scaffold(
  appBar: AppBar(
    title: const Text("Mentor List"),
    titleTextStyle: GoogleFonts.orbitron(
    fontSize: 20,fontWeight: FontWeight.w600 , color: Colors.grey
    ),
        centerTitle: true,
  ),
  body: Center(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: BlocBuilder<GetMentorBloc, GetMentorState>(
          builder: (context, state) {
            print(state.runtimeType);
            if(state is MentorLoadedState){
              return DataTable(
                headingRowColor: MaterialStatePropertyAll(Colors.grey[300]),
                headingRowHeight: 50,
                dataRowHeight: 70,
                  columns: const [
                    DataColumn(label: Text('Sl.No')),
                    // DataColumn(label: Text('')),
                    DataColumn(label: Text('Mentors')),
                    DataColumn(label: Text('Qualification')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Subscriptions')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: [
                    for (int i = 0; i < state.mentorList.length; i++)
                      DataRow(cells: [
                        DataCell(Text("$i")),
                        DataCell(Row(
                          children: [
                            CircleAvatar(backgroundImage:NetworkImage(state.mentorList[i].photo) ,),
                            SizedBox(width: 10,),
                            Text(state.mentorList[i].name)
                          ],
                        )),
                        // DataCell(Text(state.mentorList[i].name)),
                        DataCell(Text(state.mentorList[i].qualification)),
                        DataCell(Text("available")),
                        DataCell(Text('')),
                        DataCell(IconButton(onPressed: () {
                          showEditBox(context,state,i);
                        }, icon: const Icon(Icons.edit_outlined))),
                        DataCell(IconButton(onPressed: () {
                          deleteDialog(context, state.mentorList[i].id);
                          context.read<GetMentorBloc>().add(MentorLoadEvent());
                        }, icon: const Icon(Icons.delete_outline))),
                      ]),
                  ],
                );
            }
            return Text("Something went wrong");
          },
        ),
      ),
    ),
  ),
);

  }

  Future<void>  deleteDialog(BuildContext context,String id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete mentor?'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This mentor will be removed and cannot be recovered.'),
              Text('Would you like to approve this?'),
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
              deleteMentor(context, id);
              Future.delayed(Duration(seconds: 3)).then((value){
                 Navigator.pop(context);
              });
             
            },
          ),
        ],
      );
    },
  );
}

  Future<void> showEditBox(BuildContext context,MentorLoadedState state,int i) async {
    String oldImage = state.mentorList[i].photo;
    _nameController.text = state.mentorList[i].name;
    _contactController.text = state.mentorList[i].contact;
    _emailController.text = state.mentorList[i].email;
    _qualificationController.text = state.mentorList[i].qualification;
    selectedGender = state.mentorList[i].gender;
    _dobController.text = state.mentorList[i].dob;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Mentor Details'),
        content: SingleChildScrollView(
          child: Container(
            width: (MediaQuery.of(context).size.width)/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
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
                                onTap: () {},
                                child:CircleAvatar(
                                  radius: 30,
                                  backgroundImage:MemoryImage(state.imageFile),
                                )
                              );
                            }
                           return GestureDetector(
                                onTap: () {
                                  context.read<MentorBloc>().add(ImageUpdateEvent());
                                },
                                child:CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(oldImage),
                                )
                              );
                          },
                        ),
                        // TextFormField(controller: controller, label: label, validator: (validateField(value))),
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
                          validator: validateField,
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
                          validator: validateField,
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
                              child: Text(gender)
                            );
                          }).toList(), 
                          onChanged: (String? newValue){
                            selectedGender = newValue;
                          },
                          decoration: const InputDecoration(
                            hintText: "Gender"
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(controller: _dobController, readOnly: true, decoration: const InputDecoration(label: Text("Date of birth"), border: OutlineInputBorder()),)
                            ),
                            IconButton(
                              onPressed: () {_selectDob(context);},
                              icon: const Icon(Icons.calendar_month)
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                _nameController.clear();_contactController.clear();_dobController.clear();_emailController.clear();_genderController.clear();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red[500])
                              ),
                              child: const Text("Clear", style: TextStyle(color: Colors.white))
                            ),
                            const SizedBox(width: 20,),
                            ElevatedButton(
                              onPressed: (){
                                 editMentor(context,state.mentorList[i].id);
                                
                                // Map<String,String> data ={

                                // };
                                // print(1);
                                // context.read<MentorBloc>().add(EditMentorEvent(data: data, mentorId: state.mentorList[i].id));
                                // print(2);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.green[500])
                              ),
                              child: const Text("Register", style: TextStyle(color: Colors.white))
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void editMentor(BuildContext context,String id)async{
    if(newImage == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a new Image"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(dob == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select date of birth to be updated"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));
    }
    else if(_formKey.currentState!.validate() && newImage != null && dob != null){
  // print(1);
  firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("language${_nameController.text.trim()}");
  // print(2);
  firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updating data"),backgroundColor: Colors.green,duration: Duration(seconds: 3),));
  // print(3);

  await uploadTask;
  // print(4);
    var downloadUrl = await ref.getDownloadURL();
    // print("image link $downloadUrl");
    // String mentorId = FirebaseFirestore.instance.collection("mentors").doc().id;

      Map<String,String> data = {
        "mentorId" : id,
        "photo" : downloadUrl,
        "name" : _nameController.text.trim(),
        "contact" : _contactController.text.trim(),
        "email" : _emailController.text.trim(),
        "qualification" : _qualificationController.text.trim(),
        "gender" : selectedGender ?? "not specified",
        "dob" : dob.toString(),
      };
      print(data);
    await context.read<MentorBloc>()..add(EditMentorEvent(data: data,mentorId: id));
    Navigator.pop(context);
    context.read<GetMentorBloc>().add(MentorLoadEvent());
    }
    else{
      print("form not validated");
    }
  }


void deleteMentor(BuildContext context,String id){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleting mentor data"),backgroundColor: Colors.red,duration: Duration(seconds: 3),));
  context.read<MentorBloc>().add(DeleteMentorEvent(mentorId:id ));
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
   String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
    _dobController.text = formattedDate.toString();
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
  
}
