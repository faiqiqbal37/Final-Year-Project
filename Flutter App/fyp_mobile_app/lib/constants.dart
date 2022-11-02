import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// colors to use in the app

const kPrimaryColor = Color(0xFF47B5FF);
const kTextColor = Color(0xFF06283D);
const kBackgroundColor = Color(0xFFDFF6FF);

String uri = 'http://10.135.48.207:4000';

const double kDefaultPadding = 20.0;

List list = [
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
];

const List<Map<String, String>> categoryImages = [
  {
    'title': 'Car wash',
    'image': 'assets/images/carWash.png',
  },
  {
    'title': 'Mechanical work',
    'image': 'assets/images/mechanicalWork.png',
  },
  {
    'title': 'Electrical work',
    'image': 'assets/images/electricalWork.png',
  },
  {
    'title': 'Roadside assistance',
    'image': 'assets/images/roadsideAssistance.png',
  },
  {
    'title': 'Wheel Alignment',
    'image': 'assets/images/wheelAlignment.png',
  },
  {
    'title': 'Detailing',
    'image': 'assets/images/detailing.png',
  },
];
