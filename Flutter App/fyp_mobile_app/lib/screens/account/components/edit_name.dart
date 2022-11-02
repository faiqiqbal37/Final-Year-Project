import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class EditName extends StatefulWidget {
  static const String routeName = '/edit-name';
  const EditName({Key? key}) : super(key: key);

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    nameController.text = user.name;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Name',
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
                'Edit your name to be used to address you',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter something';
                  } else if (value != null &&
                      RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
                    return 'Enter your name';
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
                        FocusScope.of(context).unfocus();
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
