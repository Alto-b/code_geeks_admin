
import 'package:code_geeks_admin/application/get_subscription_bloc/get_subscription_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubListTable extends StatelessWidget {
  const SubListTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<GetSubscriptionBloc>().add(GetSubscriptionLoadEvent());
    return BlocBuilder<GetSubscriptionBloc, GetSubscriptionState>(
      builder: (context, state) {
        if(state is GetSubscriptionLoadedState){
          return DataTable(
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
                   DataCell(Text("$i")),
                   DataCell(Text(state.subscriptionList[i].title)),
                   // DataCell(Text(state.mentorList[i].name)),
                   DataCell(Text("${state.subscriptionList[i].descritpion.substring(0,10)}....")),
                   DataCell(Text(state.subscriptionList[i].language)),
                   DataCell(Text(state.subscriptionList[i].amount)),
                   DataCell(Row(
                     children: [
                       IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
                       IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline))
                     ],
                   )),
                  //  DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline))),
                 ]),
             ],
           );
           
        }
      else if(state is GetSubscriptionInitial){
        return Text("Loading...");
      }
      return Text("Add subcsription to be listed.");
      },
    );
  }
}

