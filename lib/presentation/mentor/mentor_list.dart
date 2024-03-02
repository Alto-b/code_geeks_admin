import 'package:code_geeks_admin/application/get_mentor_bloc/get_mentor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MentorListPage extends StatelessWidget {
  MentorListPage({super.key});

  final List<String> list = ['a', 'g', 'v', 'r','a', 'g', 'v', 'r','a', 'g', 'v', 'r','a', 'g', 'v', 'r'];

  @override
  Widget build(BuildContext context) {
    context.read<GetMentorBloc>().add(MentorLoadEvent());
    
    // List<DataRow> buildRows() {
    //   List<DataRow> rows = [];
    //   for (int i=0;i<list.length;i++) {
    //     rows.add(
    //       DataRow(cells: [
    //         DataCell(Text("$i")), 
    //         DataCell(Text(list[i])), // Adjust as needed for other cells
    //         const DataCell(Text('asdddddddddddddddddddddddddddddaaaaaaaaaaaarr')), // Additional cells if needed
    //         const DataCell(Text('ssssssssssssssssssssssss')), // Additional cells if needed
    //         const DataCell(Text('')), // Additional cells if needed
    //         DataCell(IconButton(onPressed: (){}, icon: const Icon(Icons.edit_outlined))), // Additional cells if needed
    //         DataCell(IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline))),
    //       ]),
    //     );
    //   }
    //   return rows;
    // }

    return  Scaffold(
  appBar: AppBar(
    title: const Text("Mentor List"),
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
                        DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined))),
                        DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline))),
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
}
