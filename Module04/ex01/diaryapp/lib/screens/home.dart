import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tab_diary.dart';
import 'tab_profile.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({
    super.key,
    required this.user,
  });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    // タブの作成
    _widgetOptions = <Widget>[
      ProfileTab(user: widget.user),
      DiaryTab(user: widget.user),
    ];

    super.initState();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (int selectedIndex) {},
          children: _widgetOptions,
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.blueGrey.shade300,
          indicatorColor: Colors.blueGrey.shade800,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.calendar_month,
              ),
              label: 'Diary',
            ),
          ],
        ),
      ),
    );
  }
}
