import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project/ui/utils/assets_path.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.appBar,
  });

  final Widget child;
  final Widget?
      floatingActionButton; //these are giving the option to add FAB and appBar in our screen if we need in any screen.
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      //If you keep the Stack (with the background) inside the Scaffold, then when the keyboard appears, the Scaffold resizes its body, causing the Stack — and therefore the background image — to shrink.
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            AssetsPath.backgroundSvg,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          floatingActionButton: floatingActionButton,


          appBar: appBar,
          body: SafeArea(child: child),
        )
      ],
    );
  }
}
