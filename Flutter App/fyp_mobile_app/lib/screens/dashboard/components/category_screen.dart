import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';

  final String category;
  final String image;
  const CategoryScreen({Key? key, required this.category, required this.image})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kTextColor,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,
            width: size.width,
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            margin: EdgeInsets.only(bottom: kDefaultPadding),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.category,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.only(
                    left: kDefaultPadding / 1.6, right: kDefaultPadding / 1.6),
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    mainAxisExtent: 300),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: CategoryPopulate(size: size),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
