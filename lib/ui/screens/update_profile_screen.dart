import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/pass_TFF_widget.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/update_profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC =
      TextEditingController(); //Controllers must be created in the state class otherwise a error called 'controller was disposed' will come because then controller will not be created whenever we come to the screen as we haven't kept them inside the state class.
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(
        ifUpdateProfileScreen: true,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  _buildPhotoPicker(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailTEC,
                    decoration: const InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _firstNameTEC,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _lastNameTEC,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _mobileTEC,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PassTFFWidget(controller: _passTEC, hintText: 'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.arrow_right_circle),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      height: 52,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: const Text(
              'Photo',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Text('No Item Selected')
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _mobileTEC.dispose();
    _passTEC.dispose();
  }
}
