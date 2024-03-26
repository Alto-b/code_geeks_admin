import 'package:code_geeks_admin/application/get_booking_bloc/get_booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ActiveSubsPage extends StatelessWidget {
  const ActiveSubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetBookingBloc>().add(LoadBookingsEvent());
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        title: const Text("active subs"),
        titleTextStyle: GoogleFonts.orbitron(
        fontSize: 20,fontWeight: FontWeight.w600 , color: Colors.grey
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: screenWidth,
                child: BlocBuilder<GetBookingBloc, GetBookingState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if(state is GetBookingsLoadedState){
                      return Container(
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
                                       DataColumn(label: Text('Subscription')),
                                       DataColumn(label: Text('Duration')),
                                       DataColumn(label: Text('Guide')),
                                       DataColumn(label: Text('User')),
                                       DataColumn(label: Text('Amount')),
                                      //  DataColumn(label: Text('Action')),
                                     ],
                                     rows: [
                                       for (int i = 0; i <state.bookingsList.length; i++)
                                         DataRow(cells: [
                                           DataCell(Text("${i+1}")),
                                           DataCell(Text(state.bookingsList[i].sub_title)),
                                           DataCell(Text("${state.bookingsList[i].date}  🢡  ${state.bookingsList[i].expiry}")),
                                           DataCell((state.bookingsList[i].guide_name)=="0" ? Text("Unassigned",style: TextStyle(
                                            color: Colors.orange
                                           ),) :Text(state.bookingsList[i].guide_name,style: TextStyle(
                                            color: Colors.green
                                           ),)),
                                           DataCell(Text(state.bookingsList[i].user_name)),
                                           DataCell((state.bookingsList[i].booking_amount == "0")?Text("Free") :Text(state.bookingsList[i].booking_amount)),
                                          //  DataCell(IconButton(onPressed: (){}, icon: Icon(Icons.remove_circle_outline_outlined))),
                                         ]),
                                     ],
                                   ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}

