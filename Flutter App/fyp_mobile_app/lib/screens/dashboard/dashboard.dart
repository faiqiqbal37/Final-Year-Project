import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/body.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = '/dashboard-screen';
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
