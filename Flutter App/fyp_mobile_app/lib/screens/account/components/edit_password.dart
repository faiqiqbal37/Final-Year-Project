import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPassword extends StatefulWidget {
  static const String routeName = '/edit-password';

  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final formKey = GlobalKey<FormState>();
  late String oldPass;

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    getPassword();
    super.initState();
  }

  void getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = await prefs.getString('password');
    if (password != null) {
      Provider.of<Email>(context, listen: false).setPassword(password);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String oldPass = Provider.of<Email>(context).password;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: kTextColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: kDefaultPadding * 2),
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Make sure your password is 8 characters or longer',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: oldPasswordController,
                obscureText: true,
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
                  border: OutlineInputBorder(),
                  hintText: 'Old password',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
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
                  border: OutlineInputBorder(),
                  hintText: 'New password',
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: kDefaultPadding),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState != null) {
                      if (formKey.currentState?.validate() == true) {
                        if (oldPasswordController.text == oldPass) {
                          print('yeah');
                        } else {
                          print('Not yeah');
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    elevation: 4.5,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.save_as_sharp,
                        size: 30,
                      ),
                      SizedBox(
                        width: size.width * 0.28,
                      ),
                      Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
