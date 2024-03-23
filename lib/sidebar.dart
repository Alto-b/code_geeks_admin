
import 'package:code_geeks_admin/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_admin/main.dart';
import 'package:code_geeks_admin/presentation/dashboard/dashboard.dart';
import 'package:code_geeks_admin/presentation/languages/add_language.dart';
import 'package:code_geeks_admin/presentation/login/login.dart';
import 'package:code_geeks_admin/presentation/mentor/add_mentor.dart';
import 'package:code_geeks_admin/presentation/mentor/mentor_list.dart';
import 'package:code_geeks_admin/presentation/subscriptions/active_subs.dart';
import 'package:code_geeks_admin/presentation/subscriptions/add_subs.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarPage extends StatelessWidget {
   SidebarPage({Key? key}) : super(key: key);
  int index = 0;

  final screens = [
     DashBoardPage(),
    AddMentorPage(),
    MentorListPage(),
     ActiveSubsPage(),
    AddLanguagePage(),
    SubscriptionPage(),
    LoginPage(),
  ];

  final AssetImage _avatarImg = const AssetImage('lib/assets/logo.png');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body :CollapsibleSidebar(
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
      text: 'Mentors list',
      icon: Icons.group,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+2));
      },
    ),
    CollapsibleItem(
      text: 'Active subscriptions',
      icon: Icons.timelapse_rounded,
      onPressed: () {
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+3));
      }
    ),
    CollapsibleItem(
      text: 'Languages',
      icon: Icons.language,
      onPressed: () {
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+4));
      }
    ),
    CollapsibleItem(
      text: 'Subscriptions',
      icon: Icons.subscriptions,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+5));
      }
    ),
    CollapsibleItem(
      text: 'Feedback',
      icon: Icons.feedback_outlined,
      onPressed: (){
        BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+6));
      }
    ),
  ],
        avatarImg: _avatarImg,
        title: 'Admin',

        body:  BlocBuilder<SidebarBloc, SidebarState>(
          builder: (context, state) {
            print(state);
            if(state is SidebarInitial ){
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize:const Size(200, 80),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const admin_appbar())),
                body: screens[state.index],
                );
            }
            return screens[0];
          },
        ),
        
        backgroundColor: Colors.transparent,
        selectedTextColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedTextColor: Colors.grey,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [],
        collapseOnBodyTap: true,
        fitItemsToBottom: true,
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
      backgroundColor: Colors.grey,
      title: const Text("Welcome baack !",style: TextStyle(color: Colors.white),),
                 actions:  [
                  CircleAvatar(backgroundColor: Colors.grey,),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){logOutBox(context);}, icon: Icon(Icons.logout)),
                  SizedBox(width: 10,),
                 ],
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5,
                 toolbarHeight: 70,
    );
  }

    // alert box start n 

    void logOutBox(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              signout(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }



  // alert box end




  signout(BuildContext ctx) async{

    final _sharedPrefs= await SharedPreferences.getInstance();
  await _sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
    _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  }

}
