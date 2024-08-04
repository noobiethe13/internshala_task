import 'package:flutter/material.dart';
import 'package:internshala_task/core/bottom_nav_bar.dart';
import 'package:internshala_task/features/filter/ui/screens/filter_screen.dart';
import 'package:internshala_task/features/internships/ui/screens/internship_search_screen.dart';


class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavBar());

      case '/search':
        return MaterialPageRoute(builder: (_) => const InternshipSearchScreen());

      case '/filter':
        return MaterialPageRoute(builder: (_) => const FilterScreen());

      default:
        return ErrorRoute();
    }
  }

  static Route<dynamic> ErrorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

}