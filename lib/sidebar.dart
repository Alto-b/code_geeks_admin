import 'dart:math' as math show pi;

import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/presentation/dashboard/dashboard.dart';
import 'package:code_geeks_admin/presentation/login/login.dart';
import 'package:code_geeks_admin/presentation/mentor/add_mentor.dart';
import 'package:code_geeks_admin/presentation/subscriptions/active_subs.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarPage extends StatelessWidget {
   SidebarPage({Key? key}) : super(key: key);
  int index = 0;

  final screens = [
    DashBoardPage(),
    AddMentorPage(),
    ActiveSubsPage(),
    LoginPage(),
    LoginPage(),
    LoginPage(),
  ];

  final String _headline = 'Dashboard'; // Set the initial headline here

  final AssetImage _avatarImg = const AssetImage('lib/assets/logo.png');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        isCollapsed: true,
        items: [
    CollapsibleItem(
      text: 'Dashboard',
      icon: Icons.assessment,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index));
      },
      isSelected: true,
    ),
    CollapsibleItem(
      text: 'Mentors',
      icon: Icons.person,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+1));
      },
    ),
    CollapsibleItem(
      text: 'Active subscriptions',
      icon: Icons.timelapse_rounded,
      onPressed: () {
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+2));
      }
    ),
    CollapsibleItem(
      text: 'Languages',
      icon: Icons.language,
      onPressed: () => print('Languages pressed'),
    ),
    CollapsibleItem(
      text: 'Subscriptions',
      icon: Icons.subscriptions,
      onPressed: () => print('Subscriptions pressed'),
    ),
    CollapsibleItem(
      text: 'Feedback',
      icon: Icons.feedback_outlined,
      onPressed: () => print('Feedback pressed'),
    ),
  ],
        avatarImg: _avatarImg,
        title: 'Admin',

        body:  BlocBuilder<SidebarBloc, SidebarState>(
          builder: (context, state) {
            print(state);
            if(state is SidebarInitial ){
              return Scaffold(
                // appBar: PreferredSize(
                //   preferredSize: size,
                //   child: admin_appbar()),
                body: screens[state.index],
                );
            }
            return screens[0];
          },
        ),
        
        backgroundColor: Colors.black87,
        selectedTextColor: Color.fromARGB(255, 255, 255, 255),
        unselectedTextColor: Colors.grey,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [],
        collapseOnBodyTap: true,
        itemPadding: 10,
        selectedIconBox: Colors.deepOrange,
        selectedIconColor: Colors.pink,
        showTitle: true,
        avatarBackgroundColor: Colors.red,
        
      ),
    );
  }

}

class admin_appbar extends StatelessWidget {
  const admin_appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Welcome back !"),
      actions: [
        CircleAvatar()
      ],
    );
  }
}
