import 'package:cloudkitchen/screens/events.dart';
import 'package:cloudkitchen/screens/food.dart';
import 'package:cloudkitchen/screens/help.dart';
import 'package:cloudkitchen/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 20);
  double gap = 10;

  int _index = 0;

  List<Widget> screens = const [
    FoodScreen(),
    EventScreen(),
    HelpScreen(),
    ProfileScreen()
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber.shade50,
        extendBody: true,
        body: PageView.builder(
            itemCount: 4,
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _index = page;
              });
            },
            itemBuilder: (context, position) {
              return Container(
                child: Center(child: screens[position]),
              );
            }),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0, 25),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: GNav(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 500),
                tabs: [
                  GButton(
                    gap: gap,
                    icon: Icons.home,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.teal,
                    text: 'Home',
                    textColor: Colors.teal,
                    backgroundColor: Colors.amber.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: Icons.menu,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.pink,
                    text: 'Requests',
                    textColor: Colors.pink,
                    backgroundColor: Colors.pink.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: Icons.add,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.lightBlue,
                    text: 'Add Item',
                    textColor: Colors.lightBlue,
                    backgroundColor: Colors.lightBlue.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: Icons.person,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.teal,
                    text: 'Profile',
                    textColor: Colors.teal,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                ],
                selectedIndex: _index,
                onTabChange: (index) {
                  setState(() {
                    _index = index;
                  });
                  controller.jumpToPage(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
