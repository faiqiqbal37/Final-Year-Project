import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/single_featured.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../providers/emailPasswordProvider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  void navigateToCategoryPage(
      BuildContext context, String category, String image) {
    Navigator.pushNamed(context, CategoryScreen.routeName,
        arguments: CategoryScreen(category: category, image: image));
  }

  @override
  Widget build(BuildContext context) {
    List list = [
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
    ];
    final name = Provider.of<Email>(context, listen: false).fullName;
    Size size = MediaQuery.of(context).size;
    ScrollController _scrollController = ScrollController();

    _scrollToBottom() {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }

    // return Column(
    //   children: [
    //     Container(
    //       margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
    //       // it will cover 20% of our total height
    //       height: size.height * 0.4,
    //       child: Stack(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: kDefaultPadding,
    //               right: kDefaultPadding,
    //               bottom: kDefaultPadding,
    //             ),
    //             height: size.height * 0.4,
    //             width: size.width,
    //             decoration: BoxDecoration(
    //               color: kPrimaryColor,
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(36),
    //                 bottomRight: Radius.circular(36),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: kDefaultPadding * 2),
    //               child: Text(
    //                 "Hi $name!",
    //                 style: Theme.of(context).textTheme.headline4?.copyWith(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return Stack(
      children: [
        Container(),
        Container(
          padding: EdgeInsets.only(
              top: size.height * 0.33,
              left: kDefaultPadding,
              right: kDefaultPadding),
          height: size.height * 0.92,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount: categoryImages.length,
                    itemExtent: 85,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToCategoryPage(
                              context,
                              categoryImages[index]['title']!,
                              categoryImages[index]['image']!);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  categoryImages[index]['image']!,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            Text(
                              categoryImages[index]['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  'Featured',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 350,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return SingleFeatured(size: size, image: list[index]);
                    }),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * 0.27,
          width: size.width,
          padding: EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.menu_rounded,
                //     color: kTextColor,
                //     size: 30,
                //   ),
                // ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Hi, ',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'What service do\n you need?',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 16,
          child: ClipRRect(
            child: Image.asset(
              'assets/images/services.png',
              scale: 3,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }
}
