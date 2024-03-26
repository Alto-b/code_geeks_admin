import 'package:code_geeks_admin/application/get_feedback_blc/get_feedback_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetFeedbackBloc>().add(FeedbackLoadEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedbacks"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 20,fontWeight: FontWeight.w600 , color: Colors.grey
        ),
      ),

      body: Center(
        child: Column(
          children: [
            BlocBuilder<GetFeedbackBloc, GetFeedbackState>(
              builder: (context, state) {
                print(state.runtimeType);
                if(state is FeedbackLoadedState){
                  return Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: DataTable(
                       headingRowColor: MaterialStatePropertyAll(Colors.grey[300]),
                      headingRowHeight: 50,
                      dataRowHeight: 70,
                          columns: const[
                            DataColumn(label: Text("Sl.No")),
                            DataColumn(label: Text("Email id")),
                            DataColumn(label: Text("Content")),
                          ], 
                          rows: [
                            for(int i=0;i<state.feedbackList.length;i++)
                            DataRow(cells: [
                              DataCell(Text("${i+1}")),
                              DataCell(Text(state.feedbackList[i].email)),
                              DataCell(Text(state.feedbackList[i].feedback))
                            ])
                          ]
                          ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}