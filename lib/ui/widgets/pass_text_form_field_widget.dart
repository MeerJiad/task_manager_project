import 'package:flutter/material.dart';

class PassTFFWidget extends StatefulWidget {
  const PassTFFWidget({super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  State<PassTFFWidget> createState() => _PassTFFWidgetState();
}
class _PassTFFWidgetState extends State<PassTFFWidget> {
  bool _obsecurePass = true;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obsecurePass =! _obsecurePass; //here it means the current value of _obsecurePass will not be the new value so,it just flips whenever user clicks on the button as it is a boolean if the value was true it becomes false and if false it becomes true.
            });
          },
          icon: _obsecurePass
              ? Icon(
            Icons.visibility_outlined,
            color: Colors.grey.shade700,
          )
              : Icon(
            Icons.visibility_off_outlined,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      obscureText: _obsecurePass,
    );
  }
}
