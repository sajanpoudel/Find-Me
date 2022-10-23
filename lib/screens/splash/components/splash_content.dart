import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 1),
        Flexible(
          flex: 3,
          child: Image.asset(
            image!,
            height: getProportionateScreenHeight(350),
            width: getProportionateScreenWidth(320),
          ),
        ),
      ],
    );
  }
}
