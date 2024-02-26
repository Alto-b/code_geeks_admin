import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      //  appBar: PreferredSize(
      //             preferredSize: size,
      //             child: admin_appbar()),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 750,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.green,
                    child: const Column(
                      children: [
                        Text("10"),
                        Text("Languages")
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: const Column(
                      children: [
                        Text("5"),
                        Text("Mentors")
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: const Column(
                      children: [
                        Text("15"),
                        Text("Subscriptions")
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: const Column(
                      children: [
                        Text("55"),
                        Text("Users")
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}