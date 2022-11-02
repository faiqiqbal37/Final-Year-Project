import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class CategoryPopulate extends StatelessWidget {
  const CategoryPopulate({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
                fit: BoxFit.cover,
                width: size.width,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'XYZ Workshop name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/images/yellowStar.png',
                height: 18,
                width: 18,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                '4.2',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '(100+)',
                style: TextStyle(
                  fontSize: 18,
                  color: kTextColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '#11, Block E, Johar Town, B.O.R Society, Lahore',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
