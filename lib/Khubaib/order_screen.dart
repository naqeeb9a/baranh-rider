import 'package:baranh_rider/Khubaib/active_order.dart';
import 'package:baranh_rider/utils/config.dart';
import 'package:flutter/material.dart';

import '../Screens/login.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: customAppbar(
              context: context,
              text1: "Orders",
              automaticallyImplyLeading: false,
              backgroundColor: CustomColors.customOrange),
          body: const ActiveOrder()),
    );
  }
}
