import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home/items.dart';

import '../../../size_config.dart';
import 'home_header.dart';

/// Main content of the home screen.
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          HomeHeader(onSearch: (text) => setState(() => _query = text)),
          SizedBox(height: getProportionateScreenHeight(20)),
          Items(query: _query),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}
