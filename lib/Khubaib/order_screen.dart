import 'package:baranh_rider/utils/config.dart';
import 'package:baranh_rider/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../Screens/login.dart';
import '../Widgets/buttons.dart';
import '../Widgets/loader.dart';
import '../Widgets/text_widget.dart';
import '../backend/orders.dart';
import '../utils/app_routes.dart';
import 'order_detail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: CustomColors.customBlack,
        appBar: customAppbar(
          context: context,
          text1: "Orders",
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.customOrange,
        ),
        body: Column(
          children: [
            CustomSizes().heightBox(context, .02),
            SizedBox(
              height: CustomSizes().dynamicHeight(context, .04),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100.0,
                  ),
                  color: CustomColors.customOrange,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: CustomColors.customWhite,
                unselectedLabelColor: CustomColors.customOrange,
                labelStyle: TextStyle(
                  fontSize: CustomSizes().dynamicWidth(context, .034),
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: CustomSizes().dynamicWidth(context, .032),
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  Tab(
                    text: "New Orders",
                  ),
                  Tab(
                    text: "Picked Orders",
                  ),
                  Tab(
                    text: "Delivered Orders",
                  ),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .02),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(minutes: 1)),
                    builder: (context, snapshot) {
                      return FutureBuilder(
                        future: RiderFunctionality().getRiderInfo(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == false) {
                              return retry(context);
                            } else if (snapshot.data.length == 0) {
                              return Center(
                                child: text(context, "No Active Orders", 0.04,
                                    CustomColors.customWhite),
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {});
                                },
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data[index]["delorderstatus"]
                                                .toString() ==
                                            "pending" ||
                                        snapshot.data[index]["delorderstatus"]
                                                .toString() ==
                                            "null" ||
                                        snapshot.data[index]["delorderstatus"]
                                            .toString()
                                            .isEmpty) {
                                      return activeOrderCard(
                                        context,
                                        snapshot.data,
                                        index,
                                        setState,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            }
                          } else {
                            return const Loader();
                          }
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(minutes: 1)),
                    builder: (context, snapshot) {
                      return FutureBuilder(
                        future: RiderFunctionality().getRiderInfo(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == false) {
                              return retry(context);
                            } else if (snapshot.data.length == 0) {
                              return Center(
                                child: text(context, "No Active Orders", 0.04,
                                    CustomColors.customWhite),
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {});
                                },
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data[index]["delorderstatus"]
                                            .toString() ==
                                        "On the way") {
                                      return activeOrderCard(
                                        context,
                                        snapshot.data,
                                        index,
                                        setState,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            }
                          } else {
                            return const Loader();
                          }
                        },
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(minutes: 1)),
                    builder: (context, snapshot) {
                      return FutureBuilder(
                        future: RiderFunctionality().getRiderInfo(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == false) {
                              return retry(context);
                            } else if (snapshot.data.length == 0) {
                              return Center(
                                child: text(context, "No Active Orders", 0.04,
                                    CustomColors.customWhite),
                              );
                            } else {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {});
                                },
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data[index]["delorderstatus"]
                                            .toString() ==
                                        "delivered") {
                                      return activeOrderCard(
                                        context,
                                        snapshot.data,
                                        index,
                                        setState,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            }
                          } else {
                            return const Loader();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget activeOrderCard(BuildContext context, snapshot, index, setState) {
  return InkWell(
    onTap: () {
      CustomRoutes().push(
          context,
          OrderDetail(
            snapshot: snapshot,
            index: index,
            stateChange: setState,
          ));
    },
    child: Container(
      width: CustomSizes().dynamicWidth(context, 1),
      height: CustomSizes().dynamicHeight(context, 0.24),
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicHeight(context, 0.01),
      ),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: CustomColors.customOrange))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                  context,
                  "PKR " +
                      double.parse(snapshot[index]["sub_total_with_discount"])
                          .toStringAsFixed(0),
                  0.04,
                  CustomColors.customWhite,
                  bold: true),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.01),
                ),
                decoration: BoxDecoration(
                  color: CustomColors.customOrange,
                  borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.05),
                  ),
                ),
                child: text(
                    context,
                    "Order no #" + snapshot[index]["sale_no"].toString(),
                    0.03,
                    CustomColors.customWhite),
              )
            ],
          ),
          text(
              context,
              snapshot[index]["delorderstatus"] == "pending" ||
                      snapshot[index]["delorderstatus"] == null
                  ? "New Order to pick"
                  : snapshot[index]["delorderstatus"] == "delivered"
                      ? "Delivered"
                      : "Order is on the way",
              0.035,
              snapshot[index]["delorderstatus"] == "pending" ||
                      snapshot[index]["delorderstatus"] == null
                  ? CustomColors.customRed
                  : CustomColors.customGreen,
              bold: true),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: CustomColors.customOrange,
                size: CustomSizes().dynamicHeight(context, 0.015),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: text(
                      context,
                      snapshot[index]["customer"][0]["address"].toString(),
                      0.035,
                      CustomColors.customLightBlack,
                      bold: true),
                ),
              ),
            ],
          ),
          CustomSizes().heightBox(context, 0.02)
        ],
      ),
    ),
  );
}
