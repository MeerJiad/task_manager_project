import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project/ui/screens/new_task_screen.dart';
import 'package:task_manager_project/ui/utils/api_urls.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/utils/validators.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/tm_app_bar_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/addNewTask';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _postAddTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBar: const TMAppBar(
        ifAddNewTaskScreen: true,
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
                  height: 80,
                ),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _titleTEC,
                  decoration: const InputDecoration(hintText: 'Task'),
                  validator: (value) => textFormFieldDefaultValidation(
                      value, 'Enter the task title'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descriptionTEC,
                  decoration: const InputDecoration(hintText: 'Description'),
                  maxLines: 8,
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _postAddTaskInProgress == false,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      _buildAddTaskButtonOnTap();
                    },
                    child: const Icon(CupertinoIcons.arrow_right_circle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buildAddTaskButtonOnTap() {
    if (_formKey.currentState!.validate()) {
      _createTask();
    }
  }

  Future<void> _createTask() async{
    setState(() {
      _postAddTaskInProgress = true;
    });
    Map<String, String> createTaskPostRequestBody = {
      "title": _titleTEC.text.trim(),
      "description": _descriptionTEC.text.trim(),                 //As we did '_descriptionTEC.text.trim()',so database will receive ""(empty string) even if user leaves the textFormField empty because '.text'  converts anything into String.
      "status": "New"
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: ApiUrls.createTaskUrl,
      body: createTaskPostRequestBody,
    );
    setState(() {
      _postAddTaskInProgress = false;
    });
 if(response.isSuccess){
   Navigator.pushNamedAndRemoveUntil(context,MainBottomNavScreen.name,(predicate)=>false);
   snackBar(context: context, text:'Task Added Successfully');
 }else{
   snackBar(context: context, text:response.errorMessage);
 }


  }

  @override
  void dispose() {
    _descriptionTEC.dispose();
    _titleTEC.dispose();
    super.dispose();
  }
}
