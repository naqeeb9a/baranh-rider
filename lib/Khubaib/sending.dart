
import 'package:flutter/material.dart';

import '../Screens/location.dart';
import '../Screens/new_orders.dart';
import '../utils/app_routes.dart';
import '../utils/dynamic_sizes.dart';

class SendingScreen extends StatefulWidget {
  const SendingScreen({Key? key}) : super(key: key);

  @override
  _SendingScreenState createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "What are you sending?"),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.article,
            "Documents",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Food or Meals",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Clothes",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Grocries",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.book,
            "Flowers",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
          CustomSizes().heightBox(context, 0.02),
          cards(
            context,
            Icons.cake,
            "Cake",
            false,
            function: () => CustomRoutes().push(
              context,
              const LocationDetails(),
            ),
          ),
        ],
      ),
    );
  }
}
