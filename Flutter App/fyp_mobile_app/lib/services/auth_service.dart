import 'dart:convert' as convert;
import 'dart:convert';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/login/components/reset_password_page.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_otp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/error_handling.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_mobile_app/constants.dart';

import '../screens/components/bottom_bar.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/login/login_screen.dart';

class AuthService {
  // sign up with phone

  void SignUpUserPhone({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      User user = User(
          id: '',
          name: '',
          email: '',
          password: '',
          address: '',
          role: '',
          token: '',
          number: phone);

      http.Response res = await http.post(
        Uri.parse('$uri/api/phones/signUp'),
        body: jsonEncode({
          'number': phone,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('phone', phone);
          showSnackBar(context, 'OTP sent to your number');
          Navigator.pushNamed(context, VerifyOTP.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //verify Phone Number

  void verifyPhone({
    required BuildContext context,
    required String phone,
    required String otp,
    required String password,
  }) async {
    http.Response res = await http.post(
      Uri.parse('$uri/api/phones/verify'),
      body: jsonEncode({
        "number": phone,
        "password": password,
        "otp": otp,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () async {
        showSnackBar(context, 'Account created! Number verified');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      },
    );
  }

  //sign up user with email

  void SignUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        token: '',
        number: '',
        role: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/users/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //sign in user
  void SignInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', password);
      await prefs.setBool('email', true);

      http.Response res = await http.post(
        Uri.parse('$uri/api/users/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            var userProvider =
                Provider.of<UserProvider>(context, listen: false);

            userProvider.setUser(res.body);
            userProvider.user.role = 'email';
            userProvider.setUser(userProvider.user.toJson());
            print(userProvider.user.toJson());
            // userProvider.user.role = 'email';
            // print(userProvider.user.toJson());
            // userProvider.notify();

            // var finalUserProvider =
            //     Provider.of<FinalUserProvider>(context, listen: false);
            // finalUserProvider.setUser(res.body);

            // print(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            await prefs.setString('Name', jsonDecode(res.body)['name']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //sign in with Phone

  void SignInUserPhone({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', password);
      await prefs.setBool('email', false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/users/loginPhone'),
        body: jsonEncode({
          'number': phone,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // Provider.of<NumberProvider>(context, listen: false)
            //     .setUser(res.body);

            print(res.body);

            var userProvider =
                Provider.of<UserProvider>(context, listen: false);

            userProvider.setUser(res.body);
            userProvider.user.role = 'number';
            userProvider.setUser(userProvider.user.toJson());
            print(userProvider.user.toJson());

            print(jsonDecode(res.body)['token']);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // fetchData pracitice
  // void getData() async {
  //   http.Response userRes = await http.get(
  //     Uri.parse('$uri/api/services/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   var response = jsonDecode(userRes.body);
  //   for (var res in response) {
  //     print(res['firstname']);
  //   }
  // }

  //get user data
  Future<void> getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? emailPhone = prefs.getBool('email');

      if (emailPhone == true) {
        String? token = prefs.getString('x-auth-token');

        if (token == null) {
          prefs.setString('x-auth-token', '');
        }

        var tokenRes = await http.post(
          Uri.parse('$uri/api/users/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          },
        );

        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          // get user data
          http.Response userRes = await http.get(
            Uri.parse('$uri/api/users/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            },
          );
          print(userRes.body);

          var userProvider = Provider.of<UserProvider>(context, listen: false);

          userProvider.setUser(userRes.body);
          userProvider.user.role = 'email';
          userProvider.setUser(userProvider.user.toJson());
          print(userProvider.user.toJson());

          // var finalUserProvider =
          //     Provider.of<FinalUserProvider>(context, listen: false);
          // finalUserProvider.setUser(userProvider.user);
        }
      } else {
        String? token = prefs.getString('x-auth-token');

        if (token == null) {
          prefs.setString('x-auth-token', '');
        }

        var tokenRes = await http.post(
          Uri.parse('$uri/api/users/tokenIsValidPhone'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          },
        );

        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          // get user data
          http.Response userRes = await http.get(
            Uri.parse('$uri/api/users/phoneToken'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            },
          );

          print(jsonDecode(userRes.body));

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () async {
      //       SharedPreferences.setMockInitialValues({});
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       await prefs.setString('Name', jsonDecode(res.body)['name']);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return Dashboard();
      //           },
      //         ),
      //       );
      //     });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  Future<void> getUserDataPhone({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/api/users/tokenIsValidPhone'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/users/phoneToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () async {
      //       SharedPreferences.setMockInitialValues({});
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       await prefs.setString('Name', jsonDecode(res.body)['name']);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return Dashboard();
      //           },
      //         ),
      //       );
      //     });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      await sharedPreferences.setString('password', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendResetEmail(
      {required BuildContext context, required String email}) async {
    try {
      var res = await http.put(Uri.parse('$uri/api/users/forgot'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': email,
          }));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Navigator.pushNamed(context, PasswordResetPage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendNewPassword(
      {required BuildContext context,
      required String resetLink,
      required String password}) async {
    try {
      var res = await http.put(Uri.parse('$uri/api/users/reset'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'resetLink': resetLink,
            'newPass': password,
          }));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Navigator.pushNamed(context, LoginScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
