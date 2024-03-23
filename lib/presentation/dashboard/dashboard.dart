import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_admin/application/get_subscription_bloc/get_subscription_bloc.dart';
import 'package:code_geeks_admin/application/stats_bloc/stats_bloc.dart';
import 'package:code_geeks_admin/presentation/dashboard/dash_widgets/card_stats.dart';
import 'package:code_geeks_admin/presentation/dashboard/dash_widgets/dash_shimmer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    context.read<StatsBloc>().add(StatsLoadEvent());
    return Scaffold(
      //  appBar: PreferredSize(
      //             preferredSize: size,
      //             child: admin_appbar()),
      appBar: AppBar(
        title: Text("Statistics",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
           if (state is StatsLoadedState){
            return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cardStats(screenHeight: screenHeight, screenWidth: screenWidth,title: "Languages",count: state.langList.length.toString(),),
                  cardStats(screenHeight: screenHeight, screenWidth: screenWidth,title: "Subscriptions",count: state.subsList.length.toString(),),
                  cardStats(screenHeight: screenHeight, screenWidth: screenWidth,title: "Mentors",count: state.mentorList.length.toString(),),
                  cardStats(screenHeight: screenHeight, screenWidth: screenWidth,title: "Users",count: state.userList.length.toString(),),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                      height: screenHeight/2,
                      width: screenWidth/3,
                      // color: Colors.green,
                      child: PieChart(
                          // swapAnimationCurve: Curves.easeInOutCubicEmphasized,
                                  PieChartData(
                                    centerSpaceRadius: 0,
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 5,
                                    sections: [
                                      PieChartSectionData(
                                        showTitle: false,
                                        value: state.subsList.length as double,
                                        color: Colors.red,radius: (screenHeight/4)-20,
                                        titlePositionPercentageOffset: 0.1,
                                        badgeWidget: Text("Subscriptions: ${state.subsList.length}",style: chartTextStyle(),)
                                      ),
                                      PieChartSectionData(
                                        showTitle: false,
                                        value: state.langList.length as double,
                                        color: Colors.blue,radius: (screenHeight/4)-20,
                                        titlePositionPercentageOffset: 0.1,
                                        badgeWidget: Text("Languages: ${state.langList.length}",style: chartTextStyle(),)
                                      ),
                                    ]
                                  )
                                ),
                    ),
                  ),
                  Card(
                    child: Container(
                      height: screenHeight/2,
                      width: screenWidth/3,
                      // color: Colors.red,
                      child: PieChart(
                          // swapAnimationCurve: Curves.easeInOutCubicEmphasized,
                                  PieChartData(
                                    centerSpaceRadius: 0,
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 5,
                                    sections: [
                                      PieChartSectionData(
                                        showTitle: false,
                                        value: state.userList.length as double,
                                        color: Colors.green,
                                        radius: (screenHeight/4)-20,
                                        titlePositionPercentageOffset: 0.1,
                                        badgeWidget: Text("Users: ${state.userList.length}",style: chartTextStyle(),)
                                      ),
                                      PieChartSectionData(
                                        showTitle: false,
                                        value: state.mentorList.length as double,
                                        color: Colors.orange,radius: (screenHeight/4)-20,
                                        titlePositionPercentageOffset: 0.1,
                                        badgeWidget: Text("Mentors: ${state.mentorList.length}",style: chartTextStyle(),)
                                      ),
                                    ]
                                  )
                                ),
                    ),
                  )
                ],
              ),
            ],
          );
          }
        return DashStatsShimmer(screenHeight: screenHeight,screenWidth: screenWidth,);
        },
      )
        
    );
  }

  TextStyle chartTextStyle() {
    return GoogleFonts.poppins(
         fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white
     );
  }
}
