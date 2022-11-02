import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/account/components/single_product.dart';

import 'components/orders_tile.dart';

class Orders extends StatefulWidget {
  static const String routeName = '/order-history';
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temporary list

  List list = ['Pending', 'Completed', 'Pending', 'Completed'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: AppBar(
          foregroundColor: kTextColor,
          title: Text(
            'Order history',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              // size: 12,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return OrderTile(size: size, status: list[index]);
              },
            ),
          )
          // OrderTile(size: size),
          // OrderTile(size: size),
          // OrderTile(size: size),
          // OrderTile(size: size),
        ],
      ),
    );

    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Container(
    //           padding: EdgeInsets.only(left: (kDefaultPadding / 2) + 5),
    //           child: Text(
    //             'Your Orders',
    //             style: TextStyle(
    //               fontSize: 18,
    //               color: kTextColor,
    //               fontWeight: FontWeight.w600,
    //             ),
    //           ),
    //         ),
    //         // Container(
    //         //   padding: EdgeInsets.only(
    //         //     right: (kDefaultPadding / 2) + 5,
    //         //   ),
    //         //   child: Text(
    //         //     'See All',
    //         //     style: TextStyle(
    //         //       color: kPrimaryColor,
    //         //     ),
    //         //   ),
    //         // ),
    //         // display orders
    //       ],
    //     ),
    //     Container(
    //       height: 300,
    //       padding: const EdgeInsets.only(
    //           left: kDefaultPadding / 10, right: 0, top: kDefaultPadding),
    //       child: ListView.builder(
    //         itemCount: list.length,
    //         itemBuilder: (context, index) {
    //           return SingleProduct(image: list[index]);
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
