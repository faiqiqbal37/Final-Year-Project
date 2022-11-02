import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/screens/components/login_heading_with_text.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOTP extends StatefulWidget {
  static const String routeName = '/verify-otp';
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  late TextEditingController phoneController;
  late TextEditingController otpController;

  @override
  void initState() {
    phoneController = TextEditingController();
    otpController = TextEditingController();
    getPhone();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = await prefs.getString('phone');
    if (phone != null) {
      phoneController.text = phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            LoginHeadingWithText(
              size: size,
              title: "Verify Phone number",
              text: "Enter the OTP sent to your number",
              pad: kDefaultPadding,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
              child: TextFormField(
                controller: phoneController,
                enabled: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Phone number",
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
            ),
            Container(
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
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding / 2,
              ),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
              child: TextFormField(
                controller: otpController,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter something';
                  } else if (value != null && value.length < 6) {
                    return 'OTP must be 6 characters long';
                  } else if (value != null &&
                      RegExp(r'^[0-9]+$').hasMatch(value) == false) {
                    return 'Enter valid OTP';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Enter OTP",
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
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding),
              width: size.width,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState != null) {
                    if (formKey.currentState?.validate() == true) {
                      authService.verifyPhone(
                          context: context,
                          phone: phoneController.text,
                          password: Provider.of<Email>(context, listen: false)
                              .password,
                          otp: otpController.text);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  elevation: 4.5,
                ),
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
