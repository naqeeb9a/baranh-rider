import 'dart:async';

import 'package:baranh_rider/utils/config.dart';
import 'package:baranh_rider/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/login.dart';
import '../Screens/order_summary_page.dart';
import '../Widgets/buttons.dart';
import '../Widgets/loader.dart';
import '../Widgets/text_widget.dart';
import '../backend/orders.dart';
import '../utils/app_routes.dart';

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
                physics: const NeverScrollableScrollPhysics(),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100.0,
                  ),
                  color: CustomColors.customGreen,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: CustomColors.customWhite,
                unselectedLabelColor: CustomColors.customWhite,
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
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FutureBuilder(
                    future: RiderFunctionality().getRiderInfo(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                              child: ActiveOrderCard(
                                snapshot: snapshot.data,
                                tabName: "New Orders",
                                setState: () {
                                  setState(() {});
                                },
                              ));
                        }
                      } else {
                        return const Loader();
                      }
                    },
                  ),
                  FutureBuilder(
                    future: RiderFunctionality().getRiderInfo(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                              child: ActiveOrderCard(
                                snapshot: snapshot.data,
                                tabName: "Picked Orders",
                                // setState: set(),
                              ));
                        }
                      } else {
                        return const Loader();
                      }
                    },
                  ),
                  FutureBuilder(
                    future: RiderFunctionality().getRiderInfo(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                              child: ActiveOrderCard(
                                snapshot: snapshot.data,
                                tabName: "Delivered Orders",
                                // setState: set(),
                              ));
                        }
                      } else {
                        return const Loader();
                      }
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

// ignore: must_be_immutable
class ActiveOrderCard extends StatefulWidget {
  dynamic snapshot;
  final dynamic setState;
  final String tabName;

  ActiveOrderCard({
    Key? key,
    required this.snapshot,
    required this.tabName,
    this.setState,
  }) : super(key: key);

  @override
  State<ActiveOrderCard> createState() => _ActiveOrderCardState();
}

class _ActiveOrderCardState extends State<ActiveOrderCard> {
  Timer? _timer;

  startUpdating() {
    _timer = Timer.periodic(const Duration(seconds: 10), (t) async {
      var res = await RiderFunctionality().getRiderInfo();
      debugPrint("stateRefreshed");
      setState(() {
        widget.snapshot = res;
      });
    });
  }

  @override
  void initState() {
    startUpdating();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.snapshot == false)
        ? retry(context)
        : (widget.snapshot.length == 0)
            ? text(context, "No orders", 0.04, CustomColors.customWhite)
            : ListView.builder(
                itemCount: widget.snapshot.length,
                itemBuilder: (BuildContext context, int index) {
                  if (widget.tabName == "New Orders") {
                    if (widget.snapshot[index]["delorderstatus"].toString() ==
                            "pending" ||
                        widget.snapshot[index]["delorderstatus"].toString() ==
                            "null" ||
                        widget.snapshot[index]["delorderstatus"]
                            .toString()
                            .isEmpty) {
                      return actualCard(index);
                    } else {
                      return Container();
                    }
                  } else if (widget.tabName == "Picked Orders") {
                    if (widget.snapshot[index]["delorderstatus"].toString() ==
                        "On the way") {
                      return actualCard(index);
                    } else {
                      return Container();
                    }
                  } else {
                    if (widget.snapshot[index]["delorderstatus"].toString() ==
                        "delivered") {
                      return actualCard(index);
                    } else {
                      return Container();
                    }
                  }
                });
  }

  actualCard(index) {
    return Container(
      width: CustomSizes().dynamicWidth(context, 1),
      height: CustomSizes().dynamicHeight(context, 0.4),
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicHeight(context, 0.02),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.04),
        vertical: CustomSizes().dynamicHeight(context, 0.01),
      ),
      decoration: BoxDecoration(
        color: CustomColors.customLiteBlack,
        borderRadius: BorderRadius.circular(
          CustomSizes().dynamicWidth(context, 0.04),
        ),
        border: Border.all(
          color: CustomColors.customOrange,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                context,
                "Order No: ${widget.snapshot[index]["sale_no"].toString()}",
                .04,
                CustomColors.customWhite,
                bold: true,
              ),
              text(
                context,
                "Time: ${widget.snapshot[index]["order_time"].toString()}",
                .04,
                CustomColors.customWhite,
                bold: true,
              ),
            ],
          ),
          text(
            context,
            (widget.snapshot[index]["delorderstatus"].toString() == "pending" ||
                    widget.snapshot[index]["delorderstatus"].toString() ==
                        "null" ||
                    widget.snapshot[index]["delorderstatus"].toString().isEmpty)
                ? "Current Status: New Order to pick"
                : widget.snapshot[index]["delorderstatus"].toString() ==
                        "On the way"
                    ? "Current Status: Order is on the way"
                    : "Current Status: Delivered",
            .04,
            (widget.snapshot[index]["delorderstatus"].toString() == "pending" ||
                    widget.snapshot[index]["delorderstatus"].toString() ==
                        "null" ||
                    widget.snapshot[index]["delorderstatus"].toString().isEmpty)
                ? CustomColors.customRed
                : CustomColors.customGreen,
            bold: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                context,
                "Customer Phone: ${widget.snapshot[index]["customer"][0]["phone"].toString()}",
                .04,
                CustomColors.customWhite,
                bold: true,
              ),
              CustomSizes().widthBox(context, .1),
              InkWell(
                onTap: () async {
                  await canLaunch(
                          "tel:${widget.snapshot[index]["customer"][0]["phone"].toString()}")
                      ? await launch(
                          "tel:${widget.snapshot[index]["customer"][0]["phone"].toString()}")
                      : throw 'Could not launch ${widget.snapshot[index]["customer"][0]["phone"].toString()}';
                },
                child: const CircleAvatar(
                  backgroundColor: CustomColors.customBlack,
                  child: Icon(
                    Icons.phone,
                    color: CustomColors.customWhite,
                  ),
                ),
              ),
            ],
          ),
          text(
            context,
            "Cooking Status: -----",
            .04,
            CustomColors.customWhite,
          ),
          text(
            context,
            "Customer Name: ${widget.snapshot[index]["customer"][0]["name"].toString()}",
            .04,
            CustomColors.customWhite,
          ),
          text(
            context,
            "Amount: PKR ${double.parse(widget.snapshot[index]["sub_total_with_discount"]).toStringAsFixed(0)}",
            0.04,
            CustomColors.customWhite,
            bold: true,
          ),
          text(
            context,
            "Payment Status: ----",
            0.04,
            CustomColors.customWhite,
            bold: true,
          ),
          text(
            context,
            "Address: ${widget.snapshot[index]["customer"][0]["address"].toString()}",
            0.04,
            CustomColors.customWhite,
            bold: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              coloredButton(
                  context,
                  "Items (${widget.snapshot[index]["details"].length.toString()})",
                  CustomColors.customGreen,
                  width: CustomSizes().dynamicWidth(context, .36),
                  function: () {
                CustomRoutes().push(
                  context,
                  OrderSummaryPage(
                    dataDetails: widget.snapshot,
                    index: index,
                  ),
                );
              }),
              widget.snapshot[index]["delorderstatus"].toString() == "delivered"
                  ? coloredButton(
                      context,
                      "Delivered",
                      CustomColors.customGreen,
                      width: CustomSizes().dynamicWidth(context, .36),
                    )
                  : coloredButton(
                      context,
                      (widget.snapshot[index]["delorderstatus"]
                                      .toString() ==
                                  "pending" ||
                              widget.snapshot[index]["delorderstatus"]
                                      .toString() ==
                                  "null" ||
                              widget.snapshot[index]["delorderstatus"]
                                  .toString()
                                  .isEmpty)
                          ? "Pick"
                          : "Deliver",
                      CustomColors.customGreen,
                      width: CustomSizes().dynamicWidth(context, .36),
                      function: () async {
                        var res = await RiderFunctionality().setOrderStatus(
                          widget.snapshot[index]["sale_no"],
                          "not at home",
                          (widget.snapshot[index]["delorderstatus"]
                                          .toString() ==
                                      "pending" ||
                                  widget.snapshot[index]["delorderstatus"]
                                          .toString() ==
                                      "null" ||
                                  widget.snapshot[index]["delorderstatus"]
                                      .toString()
                                      .isEmpty)
                              ? "0"
                              : "1",
                          (widget.snapshot[index]["delorderstatus"]
                                          .toString() ==
                                      "pending" ||
                                  widget.snapshot[index]["delorderstatus"]
                                          .toString() ==
                                      "null" ||
                                  widget.snapshot[index]["delorderstatus"]
                                      .toString()
                                      .isEmpty)
                              ? "proceed"
                              : "deliver",
                        );
                        if (res == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: text(
                                context,
                                "Check your internt or tey again",
                                0.04,
                                CustomColors.customWhite,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: text(
                                context,
                                "Success",
                                0.04,
                                CustomColors.customWhite,
                              ),
                            ),
                          );
                          widget.setState();
                        }
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
