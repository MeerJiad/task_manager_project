import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/new_task_screen.dart';
import 'package:task_manager_project/ui/screens/progress_task_screen.dart';
import 'canceled_task_screen.dart';
import 'completed_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        //IndexedStack is a type of Widget which contains set of widgets and shows them according to the index.it Keeps all screens alive in memory Preserves their state (scrolls, form inputs, etc.) and Feels smoother when switching tabs
        index: _selectedIndex,
        children:
            _screens, // we could've also done the thing with 'body: _screens[_selectedIndex]' but in this way 'The old screen was destroyed.The new one was rebuilt from scratch.You lost scroll position, text field values, etc. it is good for lightweight apps or like when we have more than 5 or 6 tabs
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.new_label_outlined), label: 'New Task'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(
              icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
          NavigationDestination(
              icon: Icon(Icons.refresh_outlined), label: 'Progress'),
        ],
      ),
    );
  }
}
