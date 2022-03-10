import 'package:baranh_rider/Khubaib/sending.dart';
import 'package:flutter/material.dart';

import '../Screens/new_orders.dart';
import '../utils/app_routes.dart';
import '../utils/dynamic_sizes.dart';

class BookCourier extends StatefulWidget {
  const BookCourier({Key? key}) : super(key: key);

  @override
  _BookCourierState createState() => _BookCourierState();
}

class _BookCourierState extends State<BookCourier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        topBar(context, "Book A Courier"),
        CustomSizes().heightBox(context, 0.02),
        cards(
          context,
          Icons.book,
          "Up to 5 kg",
          false,
          function: () => CustomRoutes().push(
            context,
            const SendingScreen(),
          ),
        ),
        CustomSizes().heightBox(context, 0.02),
        cards(
          context,
          Icons.book,
          "Up to 10 kg",
          false,
          function: () => CustomRoutes().push(
            context,
            const SendingScreen(),
          ),
        ),
        CustomSizes().heightBox(context, 0.02),
        cards(
          context,
          Icons.book,
          "Up to 15 kg",
          false,
          function: () => CustomRoutes().push(
            context,
            const SendingScreen(),
          ),
        )
      ],
    ));
  }
}
