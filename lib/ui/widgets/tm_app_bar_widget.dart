import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/sign_in_screen.dart';
import 'package:task_manager_project/ui/screens/update_profile_screen.dart';
import 'package:task_manager_project/ui/widgets/dialog_widget.dart';

import '../utils/snack_bar.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  //Here 'Tm' means Task manager
  //App bar takes 'PreferredSizeWidget' but we need stateless also to done the ui,that's why we have implemented PreferredSizeWidget here in order to use it in the appBar.
  const TMAppBar({
    super.key,
    this.ifUpdateProfileScreen = false,
    this.ifAddNewTaskScreen =
        false, //it is optional parameter,we will just make it true from the updateProfileScreen.
  });

  final bool ifUpdateProfileScreen;
  final bool ifAddNewTaskScreen;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); //as we implemented PreferredSizeWidget then we need to override the size of the appbar,it stays kToolBarHeight in the constant dart file by default(height) and we gave the same.
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //final currentTheme = Theme.of(context).brightness;
    return AppBar(
        title: Row(
          //    //we are using title instead of leading because leading stays square and on the left so does some problem with our ui

          children: [
            GestureDetector(
              onTap: () {
                if (!widget.ifUpdateProfileScreen) {
                  //the condition means 'ifUpdateProfileScreen == false;
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }
              },
              child: Row(children: [
                const CircleAvatar(
                  radius: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meer Sun',
                      style: textTheme.labelLarge,
                    ),
                    Text(
                      'meersun08@gmail.com',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
        actions: [
          //we can't directly write if-else in the actions that why we used turnery operator here in order to avoid showing logout button in the addNewTask Screen.
          widget.ifAddNewTaskScreen
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    dialogWidget(
                        context: context,
                        dialogTitle: "Log out?",
                        contentText: "Are you sure you want to log out?",
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, SignInScreen.name);
                                snackBar(
                                    context: context,
                                    text: 'Logged out successfully!!');
                              },
                              child: const Text('Yes')),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                        ]);
                  },
                  icon: const Icon(Icons.logout_outlined),
                ),
        ]);
  }
}
