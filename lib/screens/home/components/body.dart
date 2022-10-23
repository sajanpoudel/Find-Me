import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home/items.dart';

import '../../../size_config.dart';
import 'home_header.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          const HomeHeader(),
          SizedBox(height: getProportionateScreenHeight(20)),
          const Items(),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}
