import 'package:flutter/material.dart';

import '../../../constants.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.size,
    required this.status,
  }) : super(key: key);

  final Size size;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.23,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                '#112002',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Text(
                'PKR 4077',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                '10-14-2022 /',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                ' 19:44',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 22,
                  color: status == 'Pending' ? Colors.yellow : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  elevation: 4.5,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "View details",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
