import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/registration/components/body_form.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BodyForm(),
    );
  }
}
