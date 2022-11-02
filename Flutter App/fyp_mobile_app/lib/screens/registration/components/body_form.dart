import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/buttonActive.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/textController.dart';
import 'package:fyp_mobile_app/screens/components/login_heading_with_text.dart';
import 'package:fyp_mobile_app/screens/components/switch_login_screen_button.dart';
import 'package:fyp_mobile_app/screens/login/components/password_text_field.dart';
import 'package:fyp_mobile_app/screens/registration/components/inputField.dart';
import 'package:fyp_mobile_app/screens/registration/components/sign_up_button.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;

import '../../dashboard/dashboard.dart';

class BodyForm extends StatelessWidget {
  const BodyForm({Key? key}) : super(key: key);

  static final AuthService authService = AuthService();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void signUpUser() {
      authService.SignUpUser(
        context: context,
        email: Provider.of<Email>(context, listen: false).email,
        password: Provider.of<Email>(context, listen: false).password,
        name: Provider.of<Email>(context, listen: false).fullName,
      );
    }

    Future save() async {
      String name = "";
      var url = Uri.http('192.168.100.9:3000', '/api/users/register');
      var res = await http.post(
        url,
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'name': Provider.of<Email>(context, listen: false).fullName,
          'email': Provider.of<Email>(context, listen: false).email,
          'password': Provider.of<Email>(context, listen: false).password,
          'address': Provider.of<Email>(context, listen: false).homeAdress,
        },
      );
      if (res.statusCode == 200) {
        Provider.of<Email>(context, listen: false).setFullName(res.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      } else {
        print(res.statusCode);
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            LoginHeadingWithText(
              size: size,
              title: "Enter Information",
              text: "About yourself",
              pad: 0,
            ),
            SizedBox(
              height: 30,
            ),
            InputField(
              hintTextField: "Full name",
              keyboardType: TextInputType.name,
              choice: 1,
              validate: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Enter something';
                } else if (value != null &&
                    RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
                  return 'Enter your name';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            PasswordTextField(),
            // SizedBox(
            //   height: 10,
            // ),
            // InputField(
            //   hintTextField: "Address (Format: House#, Block, Society)",
            //   keyboardType: TextInputType.streetAddress,
            //   choice: 5,
            //   validate: (String? value) {
            //     if (value != null && value.isEmpty) {
            //       return 'Enter something';
            //     } else if (value != null &&
            //         RegExp(r'^[#.0-9a-zA-Z\s,-]+$').hasMatch(value) == false) {
            //       return 'Enter correct home address';
            //     } else {
            //       return null;
            //     }
            //   },
            // ),
            SizedBox(
              height: 10,
            ),
            SignUpButton(
              size: size,
              // active: Provider.of<ButtonActive>(context).activeAll(
              //   Provider.of<ButtonActive>(context).nameActive,
              //   Provider.of<ButtonActive>(context).vehicleActive,
              //   Provider.of<ButtonActive>(context).makeActive,
              //   Provider.of<ButtonActive>(context).modelActive,
              //   Provider.of<ButtonActive>(context).homeaddressActive,
              //   Provider.of<ButtonActive>(context).activeButtonPassword,
              // ),
              press: () {
                print(formKey.currentState);
                if (formKey.currentState != null) {
                  if (formKey.currentState?.validate() == true) {
                    // save();
                    signUpUser();
                  }
                }
              },
            ),
            SwitchLoginScreenButton(
              text: "Already have an account?",
              textButton: "Log In",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
