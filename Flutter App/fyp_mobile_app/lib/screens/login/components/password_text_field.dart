import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/buttonActive.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:provider/provider.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  // late TextEditingController messageTextController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   messageTextController = TextEditingController();
  // }
  //
  // @override
  // void dispose() {
  //   messageTextController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding / 2,
      ),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
      child: TextFormField(
        obscureText: true,
        onChanged: (value) {
          Provider.of<Email>(context, listen: false).setPassword(value);
        },
        validator: (String? value) {
          if (value != null && value.isEmpty) {
            return 'Enter something';
          } else if (value != null && value.length < 8) {
            return 'Password must be 8 chars or more';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Password",
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
