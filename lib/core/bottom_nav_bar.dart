import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshala_task/features/internships/ui/screens/internship_search_screen.dart';
import 'package:internshala_task/features/placeholder/clubs_screen.dart';
import 'package:internshala_task/features/placeholder/courses_screen.dart';
import 'package:internshala_task/features/placeholder/home_screen.dart';
import 'package:internshala_task/features/placeholder/jobs_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 1;

  final List<Widget> screens = [
    const HomeScreen(),
    const InternshipSearchScreen(),
    const JobsScreen(),
    const ClubsScreen(),
    const CoursesScreen(),
  ];

  void onTap(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (activeIndex != 1) {
      setState(() {
        activeIndex = 1;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: screens[activeIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: activeIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                activeIndex == 0 ? Icons.home : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                activeIndex == 1 ? CupertinoIcons.paperplane_fill : CupertinoIcons.paperplane,
              ),
              label: 'Internships',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                activeIndex == 2 ? CupertinoIcons.briefcase_fill : CupertinoIcons.briefcase,
              ),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                activeIndex == 3 ? CupertinoIcons.person_2_fill : CupertinoIcons.person_2,
              ),
              label: 'Clubs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                activeIndex == 4 ? Icons.ondemand_video : Icons.ondemand_video_outlined,
              ),
              label: 'Courses',
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xff075b97),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
