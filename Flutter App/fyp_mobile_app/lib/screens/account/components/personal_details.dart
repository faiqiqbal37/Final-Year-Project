import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/screens/account/components/detail_tile.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_email.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_name.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_password.dart';
import 'package:fyp_mobile_app/screens/registration/components/inputField.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_provider.dart';

class PersonalDetails extends StatefulWidget {
  static const String routeName = '/personal-details';
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  void initState() {
    super.initState();
    getPassword();
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
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        foregroundColor: kTextColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DetailTile(
            size: size,
            title: 'Full Name',
            content: user.name,
            isObscure: false,
            press: () {
              Navigator.pushNamed(context, EditName.routeName);
            },
          ),
          DetailTile(
            size: size,
            title: 'Email',
            content: user.email,
            isObscure: false,
            press: () {
              Navigator.pushNamed(context, EditEmail.routeName);
            },
          ),
          DetailTile(
            size: size,
            title: 'Password',
            content: Provider.of<Email>(context).password,
            isObscure: true,
            press: () {
              Navigator.pushNamed(context, EditPassword.routeName);
            },
          ),
          DetailTile(
            size: size,
            title: 'Address',
            content: user.address == '' ? '(Set your address)' : user.address,
            isObscure: false,
            press: () {
              print('Clicked');
            },
          ),
        ],
      ),
    );
  }
}
