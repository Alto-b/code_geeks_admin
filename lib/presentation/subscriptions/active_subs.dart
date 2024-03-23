import 'package:flutter/material.dart';

class ActiveSubsPage extends StatelessWidget {
  const ActiveSubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(title: const Text("active subs"),),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: screenWidth-230,
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
                     for (int i = 0; i <10; i++)
                       DataRow(cells: [
                         DataCell(Text("$i")),
                         DataCell(Text("state.subscriptionList[i].title")),
                         // DataCell(Text(state.mentorList[i].name)),
                         DataCell(Text("{state.subscriptionList[i].descritpion.substring(0,10)}....")),
                         DataCell(Text(".language")),
                         DataCell(Text("si].amount")),
                         DataCell(Row(
                           children: [
                             IconButton(onPressed: () {
                              // showEditBox(context,state,i);
                             }, icon: const Icon(Icons.edit_outlined)),
                             IconButton(onPressed: () {
                              // deleteDialog(context, state.subscriptionList[i].subsId);
                             }, icon: const Icon(Icons.delete_outline))
                           ],
                         )),
                        //  DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline))),
                       ]),
                   ],
                 ),
              ),
            )
          ],
        ),
      ),

    );
  }
}