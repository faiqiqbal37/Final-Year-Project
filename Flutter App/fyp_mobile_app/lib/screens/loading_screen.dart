import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    getCurrentPosition();

    super.initState();
  }

  Future<bool?> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    try {
      if (!hasPermission!) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Splash();
        }));
      } else {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          setState(() => _currentPosition = position);
          getAddressFromLatLng(_currentPosition!);
        }).catchError((e) {
          debugPrint(e);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      await placemarkFromCoordinates(
              _currentPosition!.latitude, _currentPosition!.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
        });
        print(_currentAddress?.trim());
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Splash();
        }));
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitRotatingCircle(
        color: kPrimaryColor,
        size: 50,
      ),
    );
  }
}
