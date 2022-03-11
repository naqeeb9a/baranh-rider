import 'package:baranh_rider/Khubaib/active_order.dart';
import 'package:baranh_rider/Khubaib/completed.dart';
import 'package:baranh_rider/utils/config.dart';
import 'package:flutter/material.dart';

import '../Screens/login.dart';
import '../utils/dynamic_sizes.dart';

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
          body: Column(
            children: [
              Container(
                height: CustomSizes().dynamicHeight(context, 0.06),
                color: CustomColors.customBlack.withOpacity(.9),
                child: const TabBar(
                  indicatorColor: CustomColors.customOrange,
                  labelColor: CustomColors.customWhite,
                  unselectedLabelColor: CustomColors.customGrey,
                  tabs: [
                    Tab(text: "ACTIVE"),
                    Tab(text: "COMPLETED"),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ActiveOrder(),
                    CompletedOrder(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
