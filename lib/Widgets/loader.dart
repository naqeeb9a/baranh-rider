
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/dynamic_sizes.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        "assets/loading.json",
        width: CustomSizes().dynamicWidth(context, 0.4),
      ),
    );
  }
}
