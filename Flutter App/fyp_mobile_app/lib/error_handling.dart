import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, response.body);
      break;

    default:
      showSnackBar(context, response.body);
  }
}
