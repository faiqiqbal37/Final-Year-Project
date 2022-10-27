import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class LoginHeadingWithText extends StatelessWidget {
  const LoginHeadingWithText({
    Key? key,
    required this.size,
    required this.title,
    required this.text,
    required this.pad,
  }) : super(key: key);

  final Size size;
  final String title;
  final String text;
  final double pad;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(
        top: kDefaultPadding * 3,
        left: kDefaultPadding,
        bottom: pad,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title\n\n",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: "$text\n",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 26,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
