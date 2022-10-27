import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class EditEmail extends StatefulWidget {
  static const String routeName = '/edit-email';
  const EditEmail({Key? key}) : super(key: key);

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    emailController.text = user.email;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: kTextColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: kDefaultPadding * 4),
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Be sure that we can contact you through this email',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter something';
                  } else if (value != null &&
                      EmailValidator.validate(value) == false) {
                    return 'Enter valid email';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Full name',
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: kDefaultPadding),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState != null) {
                      if (formKey.currentState?.validate() == true) {
                        print('validated');
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
